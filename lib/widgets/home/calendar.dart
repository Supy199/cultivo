import 'package:animate_do/animate_do.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cultivo/blocs/home_bloc.dart';
import 'package:cultivo/views/home.dart';
import 'package:cultivo/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


class Calendar extends StatefulWidget {

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime time = DateTime(2020, 4, 20);

  DateTime time2 = DateTime(2019, 1, 15);

  DateTime time3 = DateTime(2021, 10, 20);


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    var enDatesFuture = initializeDateFormatting('en', null);

    return Container(
      height: h*0.2,
      width: w*1.0,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: ZoomIn(
        child: CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: time2,
          lastDate: time3,
          onDateSelected: (date){

             bloc.TraerAcciones(date.toString().substring(0, 10));

          },
          leftMargin: 20,
          monthColor: Colors.blueGrey,
          dayColor: Colors.greenAccent.shade400,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.green[400],
          dotsColor: Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: "es",
        ),
      ),
    );
  }
}
