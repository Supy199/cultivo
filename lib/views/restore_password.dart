import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cultivo/blocs/restore_password_bloc.dart';
import 'package:flutter/material.dart';


final blocRestorePsswd = RestorePasswordBloc(); //Inicializo el bloc

class RestorePassword extends StatefulWidget {
  @override
  _RestorePasswordState createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePassword> {
  @override
  Widget build(BuildContext context) {

    blocRestorePsswd.activarEvento.add(getControls(context: context,state: setState));

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return SlideInUp(
      child: Scaffold(
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
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: h*0.055,
                                        width: w*0.1,
                                        child: Center(
                                          child: Icon(Icons.close,color: Colors.white,size: 25,),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: w*0.04),
                                      height: h*0.035,
                                      width: w*0.55,
                                      child: Text("Recuperar contraseña",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SlideInUp(

                              child: Container(
                                margin: EdgeInsets.only(left: w*0.03,right:  w*0.05,top: h*0.04),
                                height: h*0.07,
                                width: w*1.0,
                                child: Text("Ingrese una dirección de correo electrónico para recuperar su contraseña.",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
                              ),
                            ),
                            Container(height: h*0.05,),
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
                                    blocRestorePsswd.activarEvento.add(UserEmail(email: text));
                                  },
                                ),
                              ),
                            ),

                            Container(height: h*0.05,),

                            SlideInUp(
                              delay: Duration(milliseconds: 600),
                              child: FlatButton(
                                  color: Colors.green[400],
                                  onPressed: (){
                                    blocRestorePsswd.Restore();
                                  },
                                  child: Container(
                                      height: h*0.05,
                                      width: w*0.85,
                                      child: Center(
                                        child: Text("ENVIAR EMAIL DE RECUPERACIÓN",style: TextStyle(color: Colors.white,fontSize: 17),),
                                      )
                                  )
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
                  stream: blocRestorePsswd.getCargando,
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
      ),
    );
  }
}
