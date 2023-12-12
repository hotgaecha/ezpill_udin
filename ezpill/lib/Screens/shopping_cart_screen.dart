import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShoppingCartScreen extends StatelessWidget {
  final String firebaseUid; // 사용자의 Firebase UID

  const ShoppingCartScreen({Key? key, required this.firebaseUid})
      : super(key: key);

  Future<List<dynamic>> fetchUserData() async {
    // 고정된 Firebase UID 사용
    const fixedFirebaseUid = 'kakao:3162463219';
    final encodedUid = Uri.encodeComponent(fixedFirebaseUid);
    final userDataUrl = Uri.parse(
        'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/basket2/api/basket2/$encodedUid');
    final userDataResponse = await http.get(userDataUrl);

    if (userDataResponse.statusCode == 200) {
      return json.decode(userDataResponse.body);
    } else {
      throw Exception('Failed to load userData');
    }
  }

  Future<List<dynamic>> fetchPillData() async {
    // 고정된 Firebase UID 사용
    const fixedFirebaseUid = 'kakao:';
    final encodedUid = Uri.encodeComponent(fixedFirebaseUid);
    final pillDataUrl = Uri.parse(
        'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/basket2/api/basket2/$encodedUid');
    final pillDataResponse = await http.get(pillDataUrl);

    if (pillDataResponse.statusCode == 200) {
      return json.decode(pillDataResponse.body);
    } else {
      throw Exception('Failed to load userData');
    }
  }

  List<String> _processPrices(List<String> prices) {
    List<String> processedPrices = [];
    String currentPrice = '';

    for (var part in prices) {
      if (currentPrice.isEmpty || currentPrice.length > 1) {
        // 현재 가격이 비어있거나 두 자리 이상인 경우, 새로운 가격으로 시작
        processedPrices.add(part);
        currentPrice = part;
      } else {
        // 현재 가격이 한 자리 숫자인 경우, 이전 가격과 합침
        currentPrice += ',$part';
        processedPrices[processedPrices.length - 1] = currentPrice;
      }
    }

    return processedPrices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "ShoppingCart"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('장바구니가 비어 있습니다.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var order = snapshot.data![index];
                DateTime dateTime = DateTime.parse(order['created_at']);
                String formattedDate =
                    "${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일";

                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(formattedDate,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('주문 번호: ${order['id']}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // 상품 정보 파싱
                      List<Map<String, dynamic>> products = [];
                      List<String> productIds = order['product_id'].split(',');
                      List<String> productTitles =
                          order['product_title'].split(',');

                      // 가격 정보 파싱
                      List<String> productPrices =
                          _processPrices(order['product_per_price'].split(','));

                      for (int i = 0; i < productIds.length; i++) {
                        products.add({
                          'product_id': productIds[i].trim(),
                          'product_title': productTitles[i].trim(),
                          'product_per_price': productPrices[i].trim(),
                          'isSelected': false,
                        });
                      }

                      // 상세 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(products: products),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const DetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double total = 0;

  void _onProductSelected(bool? isSelected, int index) {
    setState(() {
      widget.products[index]['isSelected'] = isSelected;
      total = 0;
      for (var product in widget.products) {
        if (product['isSelected']) {
          // 쉼표를 제거하고 double로 변환
          String priceWithoutComma =
              product['product_per_price'].replaceAll(',', '');
          total += double.parse(priceWithoutComma);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 정보'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                var product = widget.products[index];
                return _buildProductTile(product, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('총합:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('${total.toStringAsFixed(0)}원',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // 결제 로직을 여기에 추가하세요.
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text('결제하기'),
          ),
        ],
      ),
    );
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
        title: Text(product['product_title'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("가격: ${product['product_per_price']}원"),
        trailing: Checkbox(
          value: product['isSelected'],
          onChanged: (bool? value) {
            _onProductSelected(value, index);
          },
        ),
      ),
    );
  }
}
