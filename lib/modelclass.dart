import 'dart:io';

import 'package:flutter/material.dart';

class ModelClass {
  final String? name;
  final String? number;
  final String? chat;
  final File? Image;
   var  Date;
  var Time;

  ModelClass(
      {required this.name,
      required this.number,
      required this.chat,
      required this.Image,
       this.Date,
       this.Time
      });
}
