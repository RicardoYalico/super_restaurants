import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:super_restaurants/authentication/validators/validate-login.dart';

class LoginController extends GetxController{
  String message ='';
  void iniciarSesion(String correo, String password){
    Modelo.iniciarSesion(correo, password).then((value){
      if(value){
        message="Welcome";
        update();
      }
      else{
        message="Email or password not valid";
        update();
      }
      update();
    });
    update();
  }
}