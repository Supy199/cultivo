import 'package:cultivo/blocs/home_bloc.dart';
import 'package:cultivo/widgets/home/calendar.dart';
import 'package:cultivo/widgets/home/diary.dart';
import 'package:cultivo/widgets/home/herramientas.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Column(
        children: [
          Calendar(),
          Tools(),
          Diary()
        ],
      ),
    );
  }
}
