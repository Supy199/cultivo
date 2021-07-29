import 'package:animate_do/animate_do.dart';
import 'package:cultivo/blocs/home_bloc.dart';
import 'package:cultivo/modules/dias.dart';
import 'package:cultivo/views/home.dart';
import 'package:flutter/material.dart';


class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {


  @override
  Widget build(BuildContext context) {

    bloc.activarEvento.add(traerEstado(state: setState));

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return StreamBuilder<Dia>(
      stream: bloc.getDia,
      builder: (context, _dia) {

        Dia dia = _dia.data;

        if(!_dia.hasData){
          dia = Dia(
            realizadas: [],
            parahacer: []
          );
        }

        return Container(
          height: h*0.47,
          width: w*1.0,
          child: dia.parahacer.length == 0 && dia.realizadas.length == 0 ? Column(
            children: [
              SlideInUp(
                child: Container(
                  child: Text("DIARIO",style: TextStyle(color: Colors.white70,fontSize: 13),),
                  width: w*1.0,
                  height: h*0.022,
                  margin: EdgeInsets.only(left: w*0.02,right: w*0.6),
                ),
              ),
              SlideInUp(
                child: Card(
                  color: Colors.grey[800],
                  child: Container(
                    width: w*0.93,
                    height: h*0.04,
                    margin: EdgeInsets.only(left: w*0.02,right: w*0.02,top: h*0.01),
                    child:  Text("NADA PARA WED. APR 28",style: TextStyle(color: Colors.white70,fontSize: 13),),
                  ),
                ),
              ),

            ],
          )
          :
          SingleChildScrollView(
            child: Column(
              children: [
                SlideInUp(
                  child: Container(
                    child: Text("DIARIO",style: TextStyle(color: Colors.white70,fontSize: 13),),
                    width: w*1.0,
                    height: h*0.022,
                    margin: EdgeInsets.only(left: w*0.02,right: w*0.01),
                  ),
                ),

                dia.parahacer.length > 0 ?  SlideInUp(
                  child: Card(
                     color: Colors.grey[800],
                     child: Column(
                       children: [
                         Container(
                           width: w*0.98,
                           height: h*0.04,
                           margin: EdgeInsets.only(left: w*0.02,right: w*0.02,top: h*0.01),
                           child:  Text("ACCIONES PARA HOY",style: TextStyle(color: Colors.white70,fontSize: 13),),
                         ),
                         for (var i = 0; i <  dia.parahacer.length; i++)
                           InkWell(
                             onTap: (){
                               bloc.activarEvento.add(RealizarTarea(state: setState,context: context,accion: dia.parahacer[i],id: dia.parahacer[i].id));

                          //  final snackBar = SnackBar(duration: Duration(seconds:1),content: Text(accionesParaHoy[i].tipo_accion+ " se marco como realizada"));

                          //  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             },
                             child: Container(
                               width: w*0.9,
                               height: h*0.1,
                               child: Column(
                                 children: [
                                   Container(
                                     height: h*0.06,
                                     width: w*0.9,
                                     child:  Row(
                                       children: [
                                            Container(
                                              margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                              height: h*0.06,
                                              width: w*0.1,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:  dia.parahacer[i].colorfondo
                                              ),
                                              child: Center(
                                                child: Icon(Icons.favorite,color: Colors.white,size: 20,),
                                              ),
                                            ),
                                             Container(
                                               margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                               height: h*0.03,
                                               width: w*0.6,
                                               child: Text( dia.parahacer[i].tipo_accion,style: TextStyle(color: Colors.white,fontSize: 16),)
                                             ),
                                         Container(
                                             margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                             height: h*0.05,
                                             width: w*0.1,
                                             child:IconButton(
                                               onPressed: (){},
                                               icon: Icon(Icons.info,color: Colors.grey[400],size: 22,),
                                             )
                                         ),
                                       ],
                                     ),
                                   )

                                 ],
                               ),

                             ),
                           ),
                       ],
                     )
                   ),
                ):Text(""),
                dia.realizadas.length > 0 ?  SlideInUp(
                  child: Card(
                      color: Colors.grey[800],
                      child: Column(
                        children: [
                          Container(
                            width: w*0.98,
                            height: h*0.04,
                            margin: EdgeInsets.only(left: w*0.02,right: w*0.02,top: h*0.01),
                            child:  Text("ACCIONES REALIZADAS",style: TextStyle(color: Colors.white70,fontSize: 13),),
                          ),
                          for (var i = 0; i < dia.realizadas.length; i++)
                            InkWell(
                              onTap: (){
                                bloc.activarEvento.add(PasarTareaAPendiente(state: setState,context: context,accion: dia.realizadas[i],id: dia.realizadas[i].id));

                              },
                              child: Container(
                                width: w*0.9,
                                height: h*0.1,
                                child: Column(
                                  children: [
                                    Container(
                                      height: h*0.06,
                                      width: w*0.9,
                                      child:  Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                            height: h*0.06,
                                            width: w*0.1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: dia.realizadas[i].colorfondo
                                            ),
                                            child: Center(
                                              child: Icon(Icons.check,color: Colors.white,size: 20,),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                              height: h*0.03,
                                              width: w*0.6,
                                              child: Text(dia.realizadas[i].tipo_accion,style: TextStyle(color: Colors.white,fontSize: 16),)
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(top: h*0.003,left: w*0.02,bottom: 1),
                                              height: h*0.05,
                                              width: w*0.1,
                                              child:IconButton(
                                                onPressed: (){},
                                                icon: Icon(Icons.info,color: Colors.grey[400],size: 22,),
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                  ),
                ):Text(""),

              ],
            ),
          )
        );
      }
    );
  }
}
