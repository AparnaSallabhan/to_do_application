// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:to_do_application/utils/color_constants.dart';

class WorkCard extends StatelessWidget {
  const WorkCard({
    super.key, 
    required this.work, 
    required this.date,
    this.onChecked
    });
  
  final String work ;
  final String date;
  final void Function()? onChecked;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10),
      child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorConstants.blueLight,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(work,style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),),
                          IconButton(onPressed:onChecked, 
                          icon: Icon(Icons.check_circle_outline_rounded))
                          
                        ],),
                        Text(date)
                    ],
                  ),
                ),
    );
  }
}