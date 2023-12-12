import 'package:ezpill/Screens/calendar_screen.dart';
import 'package:ezpill/Screens/counsel_screen.dart';
import 'package:ezpill/Screens/notification_screen.dart';
import 'package:ezpill/Screens/search_screen.dart';
import 'package:ezpill/Screens/survey_screen.dart';
import 'package:ezpill/widgets/ad_widget.dart';
import 'package:ezpill/widgets/bottom_nav_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  final String kakaoUid;
  final String firebaseUid;

  const MainScreen({
    Key? key,
    required this.kakaoUid,
    required this.firebaseUid,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        leadingWidth: 120,
        leading: Image.asset("assets/icons/Logo_nav.png"), //  조금 수정 필요
        actions: [
          IconButton(
            //  Calendar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarScreen(),
                ),
              );
            },
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            //  Notification
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                //  WeeklyCalendar
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                height: 100,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.25),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2033, 12, 31),
                  focusedDay: DateTime.now(),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  headerVisible: false,
                  calendarFormat: CalendarFormat.week,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 320,
                        height: 44,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              color: Colors.black.withOpacity(0.25),
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 16,
                        child: Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: const Icon(
                            Icons.search,
                            color: Color(0xfff9b53a),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 13,
                          left: 56,
                          child: Text(
                            '어떤 영양제를 찾으세요?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.25),
                              fontSize: 15,
                              fontFamily: 'NanumSquare',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ))
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 240,
                child: AD(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Opacity(
                              opacity: 0.4,
                              child: Image.asset(
                                  "assets/icons/free-icon-pediatrician-7583659.png"),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: SizedBox(
                            width: 92,
                            child: Text(
                              '약사님과의',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 18,
                                fontFamily: 'NanumSquare',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 36,
                          left: 16,
                          child: Text(
                            '1:1 상담',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontFamily: 'NanumSquare',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CounselScreen(),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 3,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Opacity(
                              opacity: 0.4,
                              child: Image.asset(
                                  "assets/icons/free-icon-analysis-12355156.png"),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: SizedBox(
                            width: 92,
                            child: Text(
                              '설문을 통한',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 18,
                                fontFamily: 'NanumSquare',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 36,
                          left: 16,
                          child: Text(
                            '영양제 추천',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'NanumSquare',
                              fontWeight: FontWeight.w800,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurveyScreen(kakaoUid: widget.kakaoUid),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomnavBarWidget(firebaseUid: widget.firebaseUid),
    );
  }
}
