import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cultivo/blocs/login_bloc.dart';
import 'package:cultivo/views/register.dart';
import 'package:cultivo/views/restore_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _blocLogin = LoginBloc(); //Inicializo el bloc

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool obscuretext = true;

  void Dispose(){

  }

  @override
  Widget build(BuildContext context) {

    _blocLogin.activarEvento.add(getControls(context: context,state: setState));
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Scaffold(
      body:Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: h*1.0,
              width: w*1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/cannabis.jpg"),
                  fit: BoxFit.cover,
                )
              ),
              child:  ClipRRect( // Clip it cleanly.
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0005, sigmaY:0005),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: Column(
                      children: [

                        SlideInDown(
                          delay: Duration(milliseconds: 600),
                          child: Container(
                            margin: EdgeInsets.only(top: h*0.035),
                            height: h*0.07,
                            width: w*1.0,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                  },
                                  child: Container(
                                    height: h*0.055,
                                    width: w*0.1,
                                  // decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //         image: AssetImage("assets/hash.png")
                                  //     )
                                  // ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: w*0.04),
                                  height: h*0.035,
                                  width: w*0.4,
                                  child: Text("Iniciar sesión",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                          ),
                        ),

                        SlideInUp(
                          delay: Duration(milliseconds: 350),
                          child: Container(
                            margin: EdgeInsets.only(left: w*0.03,right:  w*0.05,top: h*0.1,bottom: h*0.06),
                            height: h*0.07,
                            width: w*1.0,
                            child: Text("Acceda a sus datos con su correo el electrónico registrado.",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
                          ),
                        ),



                        ZoomIn(
                          delay: Duration(milliseconds: 350),
                          child: Container(
                            margin: EdgeInsets.only(left: w*0.03,right: w*0.05),
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.white,
                                  decorationColor: Colors.white,
                                  fontSize: 17
                              ),
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  labelStyle:TextStyle(color: Colors.white),
                                  counterStyle: TextStyle(color: Colors.white),
                                  suffixStyle: TextStyle(color: Colors.white),
                                  prefixStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.white),
                                  errorStyle: TextStyle(color: Colors.white),
                                //  icon: Icon(Icons.email),
                                  labelText: "Email"
                              ),
                              onChanged: (text){
                                _blocLogin.activarEvento.add(UserControl(user: text));
                              },
                            ),
                          ),
                        ),
                        Container(height: h*0.03,),
                        ZoomIn(
                          delay: Duration(milliseconds: 350),
                          child: Container(
                            margin: EdgeInsets.only(left: w*0.03,right: w*0.05),
                            child: TextField(
                              obscureText: obscuretext,
                              style: TextStyle(
                                color: Colors.white,
                                decorationColor: Colors.white,
                                fontSize: 17
                              ),
                              cursorColor: Colors.white,

                              decoration: InputDecoration(

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle:TextStyle(color: Colors.white),
                                counterStyle: TextStyle(color: Colors.white),
                                suffixStyle: TextStyle(color: Colors.white),
                                prefixStyle: TextStyle(color: Colors.white),
                                helperStyle: TextStyle(color: Colors.white),
                                errorStyle: TextStyle(color: Colors.white),

                                //  icon: Icon(Icons.vpn_key),
                                hoverColor: Colors.white,
                                  focusColor: Colors.white,
                                  fillColor: Colors.white,
                                  labelText: "Contraseña",
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      print(obscuretext);
                                        if(obscuretext){
                                          obscuretext = false;
                                        }else{
                                          obscuretext = true;
                                        }
                                        setState(() {  });
                                    },
                                  child: Icon( obscuretext ? Icons.visibility:Icons.visibility_off,color: Colors.white,),
                                ),
                              ),
                              onChanged: (text){
                                _blocLogin.activarEvento.add(PasswordControl(password: text));
                              },
                            ),
                          ),
                        ),
                        SlideInRight(
                          delay: Duration(milliseconds: 350),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RestorePassword()),
                              );
                            },
                            child: Container(
                              height: h*0.03,
                              width: w*0.5,
                              margin: EdgeInsets.only(top: h*0.02,left: w*0.4),
                              child: Text("Olvidé mi contraseña",style: TextStyle(decoration: TextDecoration.underline,color: Colors.white),textAlign: TextAlign.right,),
                            ),
                          ),
                        ),
                        Container(height: h*0.05,),

                        SlideInUp(
                          delay: Duration(milliseconds: 600),
                          child: FlatButton(
                              color: Colors.green[400],
                              onPressed: (){
                                _blocLogin.IntentoLogin();
                              },
                              child: Container(
                                  height: h*0.05,
                                  width: w*0.85,
                                  child: Center(
                                    child: Text("INGRESAR",style: TextStyle(color: Colors.white,fontSize: 17),),
                                  )
                              )
                          ),
                        ),
                        Container(height: h*0.05,),

                        SlideInUp(
                          delay: Duration(milliseconds: 600),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: Container(
                              height: h*0.04,
                              width: w*0.7,
                              child: Row(
                                children: [
                                  Container(
                                    height: h*0.04,
                                    width: w*0.37,
                                    child: Center(
                                      child: Text("¿No tenes cuenta?",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),),
                                    ),
                                  ),
                                  Container(
                                    height: h*0.04,
                                    width: w*0.32,
                                    child: Center(
                                      child: Text("Crea tu cuenta ",style: TextStyle(decoration: TextDecoration.underline,color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: _blocLogin.getCargando,
            builder: (context, _cargando) {
              final cargando = _cargando.data ?? false;

              return cargando == true ? Positioned(
                left: 0,
                top: 0,
                child: Container(
                  height: h*1.0,
                  width: w*1.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[500],
                      backgroundBlendMode: BlendMode.darken
                ),
                  child:Center(
                    child: CircularProgressIndicator(strokeWidth: 6,),
                  )
                ),
              ):Positioned(
                top: 1,
                left: 1,
                child: Text(""),
              );
            }
          ),
        ],
      )
    );
  }
}

