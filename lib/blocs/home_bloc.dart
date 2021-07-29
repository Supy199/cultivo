import 'dart:async';
import 'package:cultivo/modules/acciones.dart';
import 'package:cultivo/modules/dias.dart';
import 'package:cultivo/views/home.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool mounted = false;

Dia dia = Dia(
  parahacer: [],
  realizadas:[],
);

List<Accion> accionesParaHoy = [];

List<Accion> accionesRealizadas = [];

Function state ;
String id = '';


class HomeBloc{

  /* Envio las acciones del dia*/
  Stream<Dia> get getDia async*{

    yield dia;
  }
  //

  /* Stream listen events */
  StreamController<BlocBase> _input = BehaviorSubject();
  StreamSink<BlocBase> get activarEvento => _input.sink;
  /**/

  HomeBloc(){
    _input.stream.listen(Evento);
  }

  void Dispose(){
    _input.close();
  }

  Evento(BlocBase event) {

    if(event is RealizarTarea){
      dia.realizadas.add(event.accion);
      dia.parahacer.remove(event.accion);

    CollectionReference acciones = FirebaseFirestore.instance.collection('acciones');

          acciones.doc(event.id)
                .update({
            "accion":event.accion.tipo_accion,
            "fecha":event.accion.fecha,
            "realizada":true,
          })
          .then((value) {

            final snackBar = SnackBar(duration: Duration(seconds:1),content: Text(event.accion.tipo_accion+ " se marco como realizada"));
            ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
            event.state((){});
          })
          .catchError((error) {
            final snackBar = SnackBar(duration: Duration(seconds:2),content: Text(error));
            ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
            event.state((){});
          });


    }

    if(event is PasarTareaAPendiente){


        CollectionReference acciones = FirebaseFirestore.instance.collection('acciones');

        acciones.doc(event.id)
            .update({
          "accion":event.accion.tipo_accion,
          "fecha":event.accion.fecha,
          "realizada":false,
        })
            .then((value) {
                dia.parahacer.add(event.accion);
                dia.realizadas.remove(event.accion);
                final snackBar = SnackBar(duration: Duration(seconds:1),content: Text(event.accion.tipo_accion+ " se marco como pendiente"));
                ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
                event.state((){});
        })
            .catchError((error) {

          final snackBar = SnackBar(duration: Duration(seconds:1),content: Text(error));
          ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
          event.state((){});

        });
    }
    if(event is traerEstado){
      state =  event.state;
    }

  }


  TraerID(idd){
    if(idd!=null){
      id = idd;
    }
  }

  TraerAcciones(fecha){
    accionesRealizadas = [];
    accionesParaHoy = [];
    dia.parahacer= [];
    dia.realizadas = [];

    if(id!=""){
         FirebaseFirestore.instance
            .collection('acciones')
            .where('fecha', isEqualTo:fecha)
             .where('id', isEqualTo:id)
            .get()
            .then((data){
                 data.docs.forEach((doc) {
                   if(doc["realizada"]){
                     accionesRealizadas.add(Accion(tipo_accion: doc["accion"],icon: Icon(Icons.add),colorfondo: Colors.red,realizada: doc["realizada"],id: doc.id,fecha: doc["fecha"]));
                   }else{
                     accionesParaHoy.add(Accion(tipo_accion: doc["accion"],icon: Icon(Icons.add),colorfondo: Colors.red[100],realizada: doc["realizada"],id: doc.id,fecha: doc["fecha"]));
                   }
                 });

                   dia = Dia(
                      fechaid: fecha,
                      parahacer: accionesParaHoy,
                      realizadas: accionesRealizadas,
                   );

                    print(dia.realizadas.length);
                    print(DateTime.now());

                    if(mounted){
                      state((){});
                      print("e");
                    }
         });
    }
  }

  getMounted(m){
    mounted = m;
    print("mounted"+mounted.toString());
  }
}



class BlocBase{}

class RealizarTarea extends BlocBase{
  Function state;
  BuildContext context;
  Accion accion;
  String id;

  RealizarTarea({this.state,this.context,this.accion,this.id});
}

class PasarTareaAPendiente extends BlocBase{
  Function state;
  BuildContext context;
  Accion accion;
  String id;

  PasarTareaAPendiente({this.state,this.context,this.accion,this.id});
}

class traerEstado extends BlocBase{
  Function state;
  traerEstado({this.state});
}


