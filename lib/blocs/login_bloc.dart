import 'dart:async';
import 'package:cultivo/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

Function LoginState;
BuildContext LoginContext;

String user = "", password = "";
bool cargando = false;
String id = '';


class LoginBloc{

  /* Envio si esta cargando*/
  Stream<bool> get getCargando async*{

    yield cargando;
  }
  //

  /* Stream listen events */
  StreamController<LoginBlocBase> _input = BehaviorSubject();
  StreamSink<LoginBlocBase> get activarEvento => _input.sink;
  /**/

  LoginBloc(){
    _input.stream.listen(Evento);
  }

  void Dispose(){
    _input.close();
  }

  Evento(LoginBlocBase event) {
    if(event is getControls){
      LoginState = event.state;
      LoginContext = event.context;
    }
    if(event is UserControl){
      user = event.user;
    }
    if(event is PasswordControl){
      password = event.password;
    }
  }

  IntentoLogin() async {

    if(user.length > 5 && password.length > 5){
      cargando = true;
      LoginState((){});
      if(!user.contains("@")){
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Email invalido"));
        ScaffoldMessenger.of(LoginContext).showSnackBar(snackBar);
        cargando = false;
        LoginState((){});
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: user,
            password: password
        );
        cargando = false;
        LoginState((){});

        Navigator.pushReplacement(
          LoginContext,
          MaterialPageRoute(builder: (context) => Home(id: userCredential.user.uid,)),
        );

      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {

          final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("No existe usuario con ese email"));
          ScaffoldMessenger.of(LoginContext).showSnackBar(snackBar);

        } else if (e.code == 'wrong-password') {

          final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Contraseña incorrecta"));
          ScaffoldMessenger.of(LoginContext).showSnackBar(snackBar);
        }

        cargando = false;
        LoginState((){});
      }
    } else{
        final snackBar = SnackBar(duration: Duration(seconds:2),content: Text("Usuario y contraseña invalidos"));
        ScaffoldMessenger.of(LoginContext).showSnackBar(snackBar);
    }
  }
}


class getControls extends LoginBlocBase {
  Function state;
  BuildContext context;

  getControls({this.state,this.context});
}

class UserControl extends LoginBlocBase {
  String user;
  UserControl({this.user});
}

class PasswordControl extends LoginBlocBase {
  String password;
  PasswordControl({this.password});
}

class LoginBlocBase {}

