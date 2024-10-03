// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/dummy_db.dart';
import 'package:to_do_application/model/work_model.dart';
import 'package:to_do_application/utils/app_sessions.dart';
import 'package:to_do_application/utils/color_constants.dart';
import 'package:to_do_application/view/home_screen/widgets/work_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController workController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final workBox = Hive.box<WorkModel>(AppSessions.workBox);

  List workKeys = [];

  @override
  void initState() {
    workKeys = workBox.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Get Things Done",
          style: TextStyle(
              color: ColorConstants.blueMain,
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
      ),

      body: Column(
        children: [
          Text("Things To Do...",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),
          Expanded(
            child: ListView.builder(
              itemCount: workKeys.length,
              itemBuilder: (context, index)  { 
//work card        
              final currentWork = workBox.get(workKeys[index]);        
              return WorkCard(
                date: "06 - 09 -2024",
                work: "shopping",
                onChecked: () {
                  
                },
              );
              }
              ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _customAddWorkBottomSheet(context);
        },
        backgroundColor: ColorConstants.blueMain,
        child: Icon(Icons.add,color: Colors.white,),
        ),

    );
  }

  Future<dynamic> _customAddWorkBottomSheet(BuildContext context,) {
    return showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add Things To Do...",
                            style: TextStyle(
                                color: ColorConstants.blueMain,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //textfield 1
                          TextField(
                            controller: workController,
                            decoration: InputDecoration(
                                hintText: "Add Work",
                                fillColor: ColorConstants.blueLight,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.5))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
//textfield2
                          TextField(
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      var selectedDate = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030));
                                          //dateController.text = selectedDate.toString();
                                      if (selectedDate != null) {
                                        dateController.text = 
                                        DateFormat("d MMM yyyy").format(selectedDate);
                                      }
                                    },
                                    icon:
                                        Icon(Icons.calendar_month_outlined)),
                                hintText: "Set Date",
                                fillColor: ColorConstants.blueLight,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                              color: Colors.black, width: 2))),                           
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Select your Priority",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          Divider(),
//row of priorities
                          Row(
                            children: List.generate(
                              DummyDb.priorities.length,
                              (index) => Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        color: DummyDb.priorities[index]
                                            ["color"]),
                                    child: Text(DummyDb.priorities[index]
                                        ["priority"]),
                                  ),
                                ),
                              )),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Save Your Work",
                          style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                                  SizedBox(height: 10,),
//save button
                                  InkWell(
                                    onTap: () {
                                      workBox.add(
                                        WorkModel(
                                          work: workController.text,
                                          date: dateController.text
                                        )
                                     );
                                      Navigator.pop(context);
                                      workController.clear();
                                      dateController.clear();
                                      workKeys = workBox.keys.toList();
                                      setState(() {});
                                      //log(workBox.get(0)!.work);
                                      //print();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.black
                                        )
                                      ),
                                      child: Text("Save",
                                         style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                                    ),
                                  )
                        ],
                      ),
                    ),
                  ),
                );
  }
}





















//       bottomNavigationBar: BottomNavigationBar(items: [
// //1      
//         BottomNavigationBarItem(
//             label: "",
//             icon: IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.blue[900],
//                 ))),
//  //2      
//         BottomNavigationBarItem(
//             label: "",
//             icon: IconButton(
//                 onPressed: () {
//                   workController.clear();
//                   dateController.clear();
//   //bottomsheet               
//                   _customAddWorkBottomSheet(context);
//                 },
//                 icon: Icon(Icons.add_circle_outline_outlined,
//                     color: Colors.blue[900]))),
//  //3     
//         BottomNavigationBarItem(
//             label: "",
//             icon: IconButton(
//                 onPressed: () async {
//                   await showDatePicker(
//                       context: context,
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime.now());
//                 },
//                 icon: Icon(Icons.calendar_month, color: Colors.blue[900]))),
//       ]),