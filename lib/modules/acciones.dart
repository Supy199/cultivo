import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Accion{

  String tipo_accion,descripcion,genetica;
  String fecha;

  int repetirNotificacion = 0;
  String hastacuando;
  bool notificar = false;
  DateTime fecha_notificacion;
  bool realizada = false;
  Color colorfondo = Colors.green[300];
  Icon icon;
  String id;

  Accion({
    this.fecha,
    this.descripcion,
    this.fecha_notificacion,
    this.genetica,
    this.hastacuando,
    this.notificar,
    this.repetirNotificacion,
    this.tipo_accion,
    this.realizada,
    this.colorfondo,
    this.icon,
    this.id
  });
}