import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class RecommendScreen extends StatelessWidget {
  final String name;
  final String recommendation;
  final String firebaseUid;

  const RecommendScreen({
    Key? key,
    required this.name,
    required this.recommendation,
    required this.firebaseUid,
  }) : super(key: key);

  Future<void> callLambdaFunction(BuildContext context) async {
    const url =
        'https://m6iecy7wn2.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds3';

    print("firebaseUid: $firebaseUid");
    print("Attempting to call Lambda function");
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'firebase_uid': firebaseUid}),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['min_cost_combination'] != null &&
            responseData['cost_up_combination'] != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ResultScreen(
              minCostCombination: responseData['min_cost_combination'],
              costUpCombination: responseData['cost_up_combination'],
              name: name,
              firebaseUid: firebaseUid,
            ),
          ));
        } else {
          print('Invalid response format');
          // TODO: Handle the error with a user-friendly message
        }
      } else {
        print('Failed to call lambda function: ${response.body}');
        // TODO: Handle the error with a user-friendly message
      }
    } catch (e) {
      print('Error occurred while calling lambda function: $e');
      // TODO: Handle the error with a user-friendly message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('영양제 조합 추천'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '$name님을 위한\n영양제 조합을 소개할게요!',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$name님은 $recommendation이(가) 부족해요',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => callLambdaFunction(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 255, 183, 0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                '다음',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> minCostCombination;
  final Map<String, dynamic> costUpCombination;
  final String name;
  final String firebaseUid;

  const ResultScreen({
    Key? key,
    required this.minCostCombination,
    required this.costUpCombination,
    required this.name,
    required this.firebaseUid,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    selectedProducts = widget.costUpCombination.entries.map((entry) {
      var productInfo = Map<String, dynamic>.from(entry.value as Map);
      return {
        ...productInfo,
        'isSelected': true,
      };
    }).toList();
  }

  void _onProductSelected(bool? isSelected, int index) {
    if (isSelected != null) {
      setState(() {
        selectedProducts[index]['isSelected'] = isSelected;
      });
    }
  }

  int get _totalPrice {
    return selectedProducts.where((product) => product['isSelected']).fold(0,
        (total, current) {
      var price = current['Product_Per_Price'];
      if (price is String) {
        return total + int.parse(price.replaceAll(',', ''));
      }
      if (price is int) {
        return total + price;
      }
      throw FormatException('Product_Per_Price is not a String or int: $price');
    });
  }

  void _navigateToSubscriptionOptions() async {
    // 선택된 제품들만 필터링
    var selectedProductsToSend = selectedProducts
        .where((product) => product['isSelected'])
        .map((product) => {
              'product_id': product['product_id'],
              'Product_Title': product['Product_Title'],
              'Product_Per_Price': product['Product_Per_Price']
            })
        .toList();

    // Lambda 함수 호출
    const url =
        'https://kn2jc2nvy7.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds4';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'firebase_uid': widget.firebaseUid, // Firebase UID를 사용하여 전송
          'products': selectedProductsToSend,
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 전송되었을 때 다음 화면으로 이동
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubscriptionOptionsScreen(
            totalPrice: _totalPrice,
            name: widget.name, // 여기서 widget.name은 필요한 정보로 사용
          ),
        ));
      } else {
        // 오류 처리
        print('Failed to update basket: ${response.body}');
      }
    } catch (e) {
      print('Error calling backend: $e');
    }
  }

  Widget _buildProductTile(Map<String, dynamic> product, int index) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.asset(
          'assets/images/${product['product_id']}.jpg',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error); // 에러 발생 시 표시할 위젯
          },
        ),
        title: Text(product['Product_Title'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("가격: ${product['Product_Per_Price']}원"),
        trailing: Checkbox(
          value: product['isSelected'],
          onChanged: (bool? value) {
            _onProductSelected(value, index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('조합 결과'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${widget.name}님을 위한 영양제 조합',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                return _buildProductTile(selectedProducts[index], index);
              },
            ),
          ),
          const Divider(),
          // Assume "영양제 추가하기" button logic is implemented elsewhere
          ElevatedButton(
            onPressed: () {
              // Logic for "영양제 추가하기" button
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 255, 183, 0),
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: const Text('영양제 추가하기'),
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 가격: $_totalPrice원',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _navigateToSubscriptionOptions,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 255, 183, 0),
                  ),
                  child: const Text('다음'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionOptionsScreen extends StatelessWidget {
  final int totalPrice;
  final String name;

  const SubscriptionOptionsScreen(
      {Key? key, required this.totalPrice, required this.name})
      : super(key: key);

  double calculateDiscountedPrice(int months) {
    final discountRates = {1: 0.0, 3: 0.05, 6: 0.10}; // 할인율 설정
    final discountRate = discountRates[months] ?? 0.0;
    return totalPrice * (1 - discountRate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name님의 구독 옵션'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              '영양제를 복용할 기간을 선택해주세요.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SubscriptionOptionTile(
              period: '1개월',
              totalPrice: totalPrice,
              discountPrice: calculateDiscountedPrice(1),
              onTap: () {
                // TODO: 구독 처리 로직 구현
              },
            ),
            SubscriptionOptionTile(
              period: '3개월',
              totalPrice: totalPrice,
              discountPrice: calculateDiscountedPrice(3),
              onTap: () {
                // TODO: 구독 처리 로직 구현
              },
            ),
            SubscriptionOptionTile(
              period: '6개월',
              totalPrice: totalPrice,
              discountPrice: calculateDiscountedPrice(6),
              onTap: () {
                // TODO: 구독 처리 로직 구현
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionOptionTile extends StatelessWidget {
  final String period;
  final int totalPrice;
  final double discountPrice;
  final VoidCallback onTap;

  const SubscriptionOptionTile({
    Key? key,
    required this.period,
    required this.totalPrice,
    required this.discountPrice,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$period (${discountPrice.toInt()}원/일)'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
