import 'package:animate_do/animate_do.dart';
import 'package:cultivo/views/add_action.dart';
import 'package:flutter/material.dart';


class Tools extends StatelessWidget {

  List<String> tools = [
    "Accion",
    "Foto",
    "Log de planta",
    "Log de ambiente",
    "Más"
  ];

  List<Color> colors = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.grey[700],
  ];

  List<IconData> icons = [
    Icons.lightbulb,
    Icons.camera_alt,
    Icons.cloud_queue,
    Icons.wb_cloudy_rounded,
    Icons.business_center
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      height: h*0.2,
      width: w*1.0,
      child: Column(
        children: [
          SlideInUp(
            child: Container(
              child: Text("HERRAMIENTAS",style: TextStyle(color: Colors.white70,fontSize: 13),),
              width: w*1.0,
              height: h*0.022,
              margin: EdgeInsets.only(left: w*0.02,right: w*0.6,bottom: 5),
            ),
          ),
          SlideInUp(
            child: Container(
              height: h*0.15,
              width: w*0.99,
              margin: EdgeInsets.only(left: w*0.02),
              child: Row(
                children: [
              for (var i = 0; i < 5; i++) InkWell(
                highlightColor: null,
                focusColor: null,
                hoverColor: null,
                splashColor: null,
                overlayColor: null,
                onTap: (){
                  print(i);
                  if(i==0){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddAction()),
                    );
                  }
                },
                child: Container(
                        width: w*0.18,
                        height: h*0.15,
                        margin: EdgeInsets.only(right: 5),
                        child: Column(
                        children: [
                           Container(
                             width: w*0.18,
                             height: h*0.09,
                              child: Center(
                                  child:Container(
                                    height: h*0.08,
                                    width: w*0.14,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors[i],
                                    ),
                                    child: Center(
                                        child:Icon(
                                          icons[i],
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                    ),
                                  )
                              ),
                             ),
                            Container(
                              width: w*0.18,
                              height: h*0.05,
                              child: Center(
                                child: Text(tools[i],style: TextStyle(color: Colors.white70,fontSize: 14),textAlign: TextAlign.center,),
                              ),
                            ),
                          ],
                        )
                      ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
