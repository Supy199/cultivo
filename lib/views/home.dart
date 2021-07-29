import 'package:cultivo/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

final bloc = HomeBloc(); // Inicializo el bloc

class Home extends StatefulWidget {
  String id ;
  Home({this.id});

  @override
  _HomeState createState() => _HomeState();
}

  class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   List<Widget> _widgetOptions = <Widget>[
     HomeScreen(),
    Text(
      'Plantas',
      style: optionStyle,
    ),
    Text(
      'Ambientes',
      style: optionStyle,
    ),
     Text(
       'Galeria',
       style: optionStyle,
     ),
     Text(
       'Mas',
       style: optionStyle,
     ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void Dispose(){

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.TraerID(widget.id);
    bloc.getMounted(this.mounted);
    bloc.TraerAcciones(DateTime.now().toString().substring(0, 10));
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
          backgroundColor:  Colors.grey[850],
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.grey[800],
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey[800],
                icon: Icon(Icons.cloud),
                label: 'Plantas',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey[800],
                icon: Icon(Icons.cloud),
                label: 'Ambientes',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey[800],
                icon: Icon(Icons.image),
                label: 'Galeria',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey[800],
                icon: Icon(Icons.dehaze),
                label: 'Mas',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.greenAccent.shade700,
            onTap: _onItemTapped,
          )
        ),

    );
  }
}
