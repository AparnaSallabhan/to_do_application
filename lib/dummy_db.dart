import 'package:flutter/material.dart';
import 'package:to_do_application/utils/color_constants.dart';

class DummyDb{
  static const List priorities =[
    {
      "priority" : "High",
      "color" : ColorConstants.blueMain
    },
        {
      "priority" : "Medium",
      "color" : Color.fromRGBO(30, 136, 229, 1)
    },
        {
      "priority" : "Low",
      "color" : Color.fromRGBO(100, 181, 246, 1)
    },
  ];

}