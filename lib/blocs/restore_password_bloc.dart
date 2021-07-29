import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

Function RestorePasswordState;
BuildContext RestorePasswordContext;

String email = '';

bool cargando = false;

class RestorePasswordBloc{

  /* Envio si esta cargando*/
  Stream<bool> get getCargando async*{
    yield cargando;
  }
  //


  /* Stream listen events */
  StreamController<RestorePasswordBlocBase> _input = BehaviorSubject();
  StreamSink<RestorePasswordBlocBase> get activarEvento => _input.sink;
  /**/


  RestorePasswordBloc(){
    _input.stream.listen(Evento);
  }

  void Dispose(){
    _input.close();
  }

  Evento(RestorePasswordBlocBase event) {

    if(event is getControls){
      RestorePasswordState = event.state;
      RestorePasswordContext = event.context;
    }
    if(event is UserEmail){
      email = event.email;
    }
  }

   Restore() async {

    try {
      cargando = true;

     await FirebaseAuth.instance.sendPasswordResetEmail(email:email).then((value) {
       Navigator.pop(RestorePasswordContext);
       final snackBar = SnackBar(duration: Duration(seconds:4),content: Text("Se envio un codigo a de recuperacion a "+ email));
       ScaffoldMessenger.of(RestorePasswordContext).showSnackBar(snackBar);
       cargando = false;
       RestorePasswordState((){});
     });

    } on FirebaseAuthException catch (e) {

      if (e.code == 'invalid-email') {
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Email Invalido."));
        ScaffoldMessenger.of(RestorePasswordContext).showSnackBar(snackBar);
      } else if (e.code == 'unknown') {
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Email Invalido."));
        ScaffoldMessenger.of(RestorePasswordContext).showSnackBar(snackBar);
      } else if (e.code == 'user-not-found') {
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("No existe cuenta con ese email."));
        ScaffoldMessenger.of(RestorePasswordContext).showSnackBar(snackBar);
      }
      cargando = false;
      RestorePasswordState((){});
    } catch (e) {
      print(e);
      cargando = false;
      RestorePasswordState((){});
    }
  }
}



class getControls extends RestorePasswordBlocBase {
  Function state;
  BuildContext context;
  getControls({this.state,this.context});
}

class UserEmail extends RestorePasswordBlocBase {
  String email;
  UserEmail({this.email});
}

class RestorePasswordBlocBase {}

