import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

// selectedDay와 focusedDay 변수 선언 및 초기화
DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();

class Event {
  String title;

  Event(this.title);
}


//마커 추가하려면 아래에 정보를 입력해야함.
Map<DateTime, List<Event>> events = {
  DateTime.utc(2023,12,13) : [ Event('title'), Event('title2') ],
  DateTime.utc(2023,12,14) : [ Event('title3') ],
};

List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
}


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6.0),
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "Calendar"),
      ),
      body: TableCalendar(
        focusedDay: focusedDay, // focusedDay 변수 사용
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2033, 12, 31),
        locale: 'ko_KR',
        daysOfWeekHeight: 30,


        headerStyle: const HeaderStyle(
          //주차 표시 버튼
          formatButtonVisible: false,

          // 글자 제어 여부
          // formatButtonShowsNext: false,

          // formatButton 글자 꾸미기
          formatButtonTextStyle: const TextStyle(fontSize: 14.0),

          formatButtonDecoration: const BoxDecoration(
            border: const Border.fromBorderSide(BorderSide()),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),

          titleCentered: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 25.0,
            color: Colors.orange,
          ), // title 글자 크기

          leftChevronPadding: const EdgeInsets.all(12.0), //왼쪽 화살표 Padding 조절
          leftChevronMargin:
          const EdgeInsets.symmetric(horizontal: 8.0), // 왼쪽 화살표 Margin 조절

          rightChevronPadding:
          const EdgeInsets.all(12.0), // rightChevron Padding 조절
          rightChevronMargin:
          const EdgeInsets.symmetric(horizontal: 8.0), // rightChevron Margin 조절
        ),
        calendarStyle: CalendarStyle(

          defaultTextStyle: TextStyle(
            color: Colors.black,
          ),
          defaultDecoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.0),
          ),
          weekendTextStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black),
          weekendDecoration: BoxDecoration(
            color: const Color(0xFFE2E2E2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),

          ),
          outsideDaysVisible: false,
          todayTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25.0,
          ),
          todayDecoration: BoxDecoration(
              color: const Color(0xffFFDFBF),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.orange, width: 1.5)),

          // selectedDay 글자 조정
          selectedTextStyle: const TextStyle(
            color: const Color(0xFFFAFAFA),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),

          // selectedDay 모양 조정
          selectedDecoration: BoxDecoration(
            color: const Color(0xFF5C6BC0),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue, width: 1.5),
          ),

          //마커
          //*****************************************************************
          //마커는 아래에서 eventLoader로 만든 이벤트 마커 표시임.
          // marker 여러개 일 때 cell 영역을 벗어날지 여부
          canMarkersOverflow: false,

          // marker 자동정렬 여부
          markersAutoAligned: true,

          // marker 크기 조절
          markerSize: 10.0,

          // marker 크기 비율 조절
          markerSizeScale: 10.0,

          // marker 의 기준점 조정
          markersAnchor: 0.7,

          // marker margin 조절
          markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),

          // marker 위치 조정
          markersAlignment: Alignment.bottomCenter,

          // 한줄에 보여지는 marker 갯수
          markersMaxCount: 4,

          // marker 모양 조정
          markerDecoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        //마커 생성
        eventLoader: _getEventsForDay,

        //아래 코드도 이벤트 생성이 가능함( 짝수일에 다 생성하는 것이며, 여기서 h는 아무 의미없는 문자열임)
        // eventLoader: (day) {
        //   if (day.day % 2 == 0) {
        //     return ['h'];
        //   }
        //   return [];
        // },



        //*****************************************************************

        // selectedDayPredicate와 onDaySelected 속성 추가
        selectedDayPredicate: (day) {
          // selectedDay와 같은 날짜를 선택하도록 함
          return isSameDay(selectedDay, day);
        },
        onDaySelected: (selectedDay2, focusedDay2) {
          // selectedDay와 focusedDay를 업데이트하고 화면을 갱신함
          setState(() {
            selectedDay = selectedDay2;
            focusedDay = focusedDay2;
          });
        },
      ),
    );
  }
}
