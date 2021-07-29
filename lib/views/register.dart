import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cultivo/blocs/register_bloc.dart';
import 'package:flutter/material.dart';

final blocRegister = RegisterBloc(); //Inicializo el bloc

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscuretext = true;
  TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    blocRegister.activarEvento.add(getControls(context: context,state: setState));
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
                                      width: w*0.4,
                                      child: Text("Crear tu cuenta",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
                                child: Text("Cree una cuenta con su correo electrónico y una contraseña.",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
                              ),
                            ),
                            SlideInUp(
                              child: Container(
                                margin: EdgeInsets.only(left: w*0.03,right:  w*0.05,bottom: h*0.1),
                                height: h*0.07,
                                width: w*1.0,
                                child: Text("El correo electronico sirve para poder recuperarla.",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),textAlign: TextAlign.left,),
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
                                    blocRegister.activarEvento.add(UserControl(user: text));
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
                                  controller: _pass,
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
                                    blocRegister.activarEvento.add(PasswordControl(password: text));
                                    setState(() {  });
                                  },
                                ),
                              ),
                            ),
                            Container(height: h*0.05,),
                            ZoomIn(
                              delay: Duration(milliseconds: 350),
                              child: Container(
                                color: Colors.grey,
                                width: w*0.92,
                                height: h*0.007,
                                child: Row(
                                  children: [
                                    Container(
                                      height: h*0.005,
                                      width: _pass.text.length>5 ?  w*0.7: _pass.text.length>4? w*0.4 : _pass.text.length>0? w*0.1:w*0,
                                      color: _pass.text.length>5 ? Colors.green: _pass.text.length>4? Colors.yellow[500]: _pass.text.length >0 ? Colors.red[500]: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(height: h*0.25,),

                            SlideInUp(
                              delay: Duration(milliseconds: 600),
                              child: FlatButton(
                                color: Colors.green[400],
                                onPressed: (){
                                  blocRegister.IntentoRegistro();
                                },
                                child: Container(
                                height: h*0.05,
                                width: w*0.85,
                                child: Center(
                                  child: Text("CREAR CUENTA",style: TextStyle(color: Colors.white,fontSize: 17),),
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
                  stream: blocRegister.getCargando,
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

