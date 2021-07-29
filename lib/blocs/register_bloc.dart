import 'dart:async';
import 'package:cultivo/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

Function RegisterState;
BuildContext RegisterContext;

String user = "", password = "";
bool cargando = false;
String id = '';


class RegisterBloc{

  /* Envio si esta cargando*/
  Stream<bool> get getCargando async*{

    yield cargando;
  }
  //

  /* Stream listen events */
  StreamController<RegisterBlocBase> _input = BehaviorSubject();
  StreamSink<RegisterBlocBase> get activarEvento => _input.sink;
  /**/

  RegisterBloc(){
    _input.stream.listen(Evento);
  }

  void Dispose(){
    _input.close();
  }

  Evento(RegisterBlocBase event) {

    if(event is getControls){
      RegisterState = event.state;
      RegisterContext = event.context;
    }
    if(event is UserControl){
      user = event.user;
    }
    if(event is PasswordControl){
      password = event.password;
    }

  }

  IntentoRegistro() async {


    if(password.length > 5){

      cargando = true;
      RegisterState((){});

      if(!user.contains("@") || !user.contains(".")){
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Email invalido"));
        ScaffoldMessenger.of(RegisterContext).showSnackBar(snackBar);
        cargando = false;
        RegisterState((){});
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: user,
            password: password
        );
        cargando = false;
        RegisterState((){});

        Navigator.push(
          RegisterContext,
          MaterialPageRoute(builder: (context) => Home(id: userCredential.user.uid,)),
        );

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {

          final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Contraseña debil"));
          ScaffoldMessenger.of(RegisterContext).showSnackBar(snackBar);

        } else if (e.code == 'email-already-in-use') {

          final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("El email ya esta en uso"));
          ScaffoldMessenger.of(RegisterContext).showSnackBar(snackBar);

        }
        cargando = false;
        RegisterState((){});
      } catch (e) {
        print(e);
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text(e));
        ScaffoldMessenger.of(RegisterContext).showSnackBar(snackBar);
        cargando = false;
        RegisterState((){});
      }
    }else{
      final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Contraseña muy debil"));
      ScaffoldMessenger.of(RegisterContext).showSnackBar(snackBar);
    }
  }
}


class getControls extends RegisterBlocBase {
  Function state;
  BuildContext context;

  getControls({this.state,this.context});
}

class UserControl extends RegisterBlocBase {
  String user;
  UserControl({this.user});
}

class PasswordControl extends RegisterBlocBase {
  String password;
  PasswordControl({this.password});
}

class RegisterBlocBase {}

