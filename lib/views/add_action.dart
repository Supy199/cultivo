import 'package:animate_do/animate_do.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';



class AddAction extends StatefulWidget {
  @override
  _AddActionState createState() => _AddActionState();
}

class _AddActionState extends State<AddAction> {
  //el primer input
  static List<AmbienteOplanta> _ambientesyplantas = [
    AmbienteOplanta(id: 1,name: "Interior",tipo: "ambiente"),
    AmbienteOplanta(id: 1,name: "Interior",tipo: "ambiente"),
    AmbienteOplanta(id: 1,name: "ak47",tipo: "planta"),
    AmbienteOplanta(id: 1,name: "Genetica desconocida",tipo: "planta"),
    AmbienteOplanta(id: 1,name: "asd",tipo: "ambiente"),
    AmbienteOplanta(id: 1,name: "ddsa",tipo: "ambiente"),
    AmbienteOplanta(id: 1,name: "3123",tipo: "planta"),
    AmbienteOplanta(id: 1,name: "Genetica deseconocida",tipo: "planta"),
  ];

  final _items = _ambientesyplantas
      .map((ambienteoplanta) => MultiSelectItem<AmbienteOplanta>(ambienteoplanta, ambienteoplanta.name))
      .toList();

  List<AmbienteOplanta> _ambientesyplantasSeleccionadas = [];
  //
  double HSelectAmbientePlanta = 0.1;

  List<String> tipos_acciones = [
    "Tipo de accion"
    "Regado",
    "Nutrientes",
    "Repelente",
    "Transplante",
    "Poda",
    "Entrenamiento",
    "Cambiar Ambiente",
    "Lavado de raíces",
    "Cosechar",
    "Declarar muerta",
    "Otro"
  ];

  List<String> imagenes = [
      "",
      "assets/rain.png",
      "assets/lab.png",
      "assets/pesticide.png",
      "assets/sprout.png",
      "assets/cutter.png",
      "assets/scion.png",
      "assets/sprout5.png",
      "assets/watering.png",
      "assets/sickle.png",
      "assets/gravestone.png",
      "assets/gamer.png",
  ];


  String one = "Tipo de accion";

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          Container(
            height: h*0.035,
            color: Colors.green,
          ),
          SlideInDown(
            child: Container(
              color: Colors.green[400],
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
                        child: Roulette(child: Icon(Icons.close,color: Colors.white,size: 25,)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: w*0.04),
                    height: h*0.035,
                    width: w*0.4,
                    child: Text("Nueva Acción",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  InkWell(
                    onTap: (){
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: w*0.22),
                      height: h*0.07,
                      width: w*0.22,
                      child:Center(
                        child: Text("GUARDAR",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),

          SlideInUp(
            delay: Duration(milliseconds: 500),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: w*0.02,bottom:HSelectAmbientePlanta == 0.1 ? h*0.01:h*0.06),
                  height: h*0.05,
                  width: w*0.08,
                  child:Center(
                    child:  SlideInLeft(
                            delay: Duration(milliseconds: 500),
                        child: Roulette(child: Icon(Icons.cloud,color: Colors.white70,))
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: h*0.02),
                  height: h*HSelectAmbientePlanta,
                  width: w*0.87,
                  child: MultiSelectBottomSheetField<AmbienteOplanta>(
                          initialChildSize: 0.4,
                          listType: MultiSelectListType.CHIP,
                          searchable: true,
                          buttonIcon:Icon(null),
                          buttonText: Text("Seleccionar plantas o ambientes",style: TextStyle(color: Colors.white70),),
                          backgroundColor: Colors.grey[800],
                          title: Text("Ambientes y plantas",style: TextStyle(color: Colors.white70),),
                          selectedColor: Colors.green[400],
                          selectedItemsTextStyle: TextStyle(color: Colors.white),
                          searchHintStyle: TextStyle(color: Colors.white70),
                          items: _items,
                          onConfirm: (values) {
                              if(values.length>0){
                                HSelectAmbientePlanta = 0.15;
                              }

                            _ambientesyplantasSeleccionadas = values;
                            setState(() { });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            chipColor: Colors.green[400],
                                        textStyle: TextStyle(color: Colors.white),
                                        scroll: true,
                                        onTap: (value) {
                                          _ambientesyplantasSeleccionadas.remove(value);

                                          if(_ambientesyplantasSeleccionadas.length==0){
                                            HSelectAmbientePlanta = 0.1;
                                          }
                                          setState(() { });
                                          },
                                        ),
                  ),
                ),
              ],
            ),
          ),

          SlideInUp(
            delay: Duration(milliseconds: 500),
            child: Row(
              children: [

                Container(
                    margin: EdgeInsets.only(left: w*0.02,),
                    height: h*0.05,
                    width: w*0.08,
                    child:Center(
                      child:  SlideInLeft(
                          delay: Duration(milliseconds: 500),
                          child: Roulette(child: Icon(Icons.lightbulb_outline,color: Colors.white70,))
                      ),
                    )
                ),

                Container(
                    margin: EdgeInsets.only(top: h*0.01),
                    height: h*0.06,
                    width: w*0.87,
                    child: DropdownButton<String>(
                      value: one,
                      dropdownColor: Colors.grey[800],
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.white
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.grey[900],
                      ),
                      onChanged: (String newValue) {

                        setState(() {
                          one = newValue;
                        });

                      },
                      items:tipos_acciones.map<DropdownMenuItem<String>>((String _item) {
                        return DropdownMenuItem<String>(
                          value: _item,
                          child: Container(
                            height: h*0.07,
                            width: w*0.7,
                            child: Row(
                              children: [
                                Container(
                                  height: h*0.05,
                                  width: w*0.07,
                                  margin: EdgeInsets.only(bottom: h*0.01,left: w*0.02),
                                  decoration:  BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(imagenes[tipos_acciones.indexOf(_item)])
                                      )
                                  ),
                                ),
                                Container(
                                  height: h*0.034,
                                  width: w*0.5,
                                  margin: EdgeInsets.only(bottom: h*0.002,left: w*0.02),
                                  child: Text(_item,textAlign: TextAlign.left,style: TextStyle(color: Colors.white70,fontSize: 16),),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                          .toList(),
                    )
                ),
              ],
            ),
          ),
          Container(
            height: h*0.025,
          ),

          SlideInUp(
            delay: Duration(milliseconds: 500),
            child: Row(
              children: [

                Container(
                    margin: EdgeInsets.only(left: w*0.02),
                    height: h*0.05,
                    width: w*0.08,
                    child:Center(
                      child:  SlideInLeft(
                          delay: Duration(milliseconds: 500),
                          child: Roulette(child: Icon(Icons.calendar_today,color: Colors.white70,))
                      ),
                    )
                ),

                Container(
                  height: h*0.06,
                  width: w*0.87,
                  child: ListTile(
                    onTap: (){
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2021, 1, 1),
                          maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                    title: Container(
                      margin: EdgeInsets.only(bottom: h*0.015),
                      child: Text("30 de abril de 2021",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide( //                    <--- top side
                        color: Colors.black,
                        width: 0.8,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          Container(
            height: h*0.025,
          ),

          SlideInUp(
            delay: Duration(milliseconds: 500),
            child: Row(
              children: [

                Container(
                    margin: EdgeInsets.only(left: w*0.02),
                    height: h*0.05,
                    width: w*0.08,
                    child:Center(
                      child:  SlideInLeft(
                          delay: Duration(milliseconds: 500),
                          child: Roulette(child: Icon(Icons.edit,color: Colors.white70,))
                      ),
                    )
                ),

                Container(
                  height: h*0.09,
                  width: w*0.87,
                  child: TextField(
                     maxLines: null,
                      expands: true,
                      cursorColor: Colors.green,
                      style: TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        hintText: "Descripcion",
                        hintStyle: TextStyle(color: Colors.white30)
                      ),
                  ),

                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}


class AmbienteOplanta {
  String tipo;
  int id;
  String name;

  AmbienteOplanta({this.id,this.name,this.tipo});
}

class Item{
  String title,imagen;

  Item({this.title,imagen});
}