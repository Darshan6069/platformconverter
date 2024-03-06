import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:platformconvetor/modelclass.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';

var formatedDate;
var datepicker;
var formateTime;
var date;
var time;

class contactAddAndroid extends StatefulWidget {
  final String? name;
  final String? number;
  final String? chat;
  final File? Image;
  final int? index;
  var Date;
  var Time;

  contactAddAndroid(
      {super.key,
      this.name,
      this.number,
      this.chat,
      this.Image,
      this.Time,
      this.Date,
      this.index});

  @override
  State<contactAddAndroid> createState() => _contactAddAndroidState();
}

class _contactAddAndroidState extends State<contactAddAndroid> {



  TextEditingController nameController = TextEditingController();
  TextEditingController numberCotroller = TextEditingController();
  TextEditingController chatController = TextEditingController();


  final formkey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              (providerVar.addImage != null)
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(providerVar.addImage!),
                    )
                  : Container(
                      height: 145,
                      width: 145,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black12),
                      child: IconButton(
                        onPressed: () {
                         showDialog(context: context, builder: (context){
                           return AlertDialog(content: Container(
                             width: width-220,
                             height: 100,
                             child: Padding(
                               padding: const EdgeInsets.only(top: 8.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   Column(
                                     children: [
                                       IconButton(onPressed: (){ providerVar.getAlbumsImage();
                                         Navigator.of(context).pop();}, icon: Icon(CupertinoIcons.photo,size: 40,)),
                                       Text('Albums',style: TextStyle(fontSize: 20)),
                                     ],
                                   ),
                                   Column(
                                     children: [
                                       IconButton(onPressed: (){ providerVar.getCameraImage();
                                       Navigator.of(context).pop();}, icon: Icon(Icons.camera,size: 40,)),
                                       Text('Camera',style: TextStyle(fontSize: 20),),
                                      ],
                                   ),
                                 ],
                               ),
                             ),
                           ),);
                         });
                        },
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          size: 30,
                        ),
                      ),
                    ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Name';
                  }
                },
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                          width: 4)),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Number';
                  }
                },
                controller: numberCotroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 4))),
                maxLength: 10,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Chat';
                  }
                },
                controller: chatController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.chat_outlined),
                    labelText: 'Chat Conversation',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.black,
                            width: 4))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: ()async {
                  date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: DateTime(3000),
                      initialDate: DateTime.now());
                  print(date);
                  if (date != null) {
                    setState(() {
                      formatedDate = DateFormat('dd/MM/yyyy').format(date);
                    });

                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Row(
                    children: [
                       Icon(Icons.date_range_outlined,size: 26,),
                      SizedBox(width: 14,),
                      (formatedDate == null) ? Text('Pick Date',style: TextStyle(fontSize: 16),) : Text(formatedDate,style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12,),
              InkWell(
                onTap: ()async {
                  time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  print(time.format(context));
                  if (time != null) {
                    datepicker = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        time.hour,
                        time.minute);
                    setState(() {
                      formateTime = DateFormat('HH:mm').format(datepicker);
                    });


                    print(formateTime);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Row(
                    children: [
                       Icon(Icons.access_time,size: 26,),
                      SizedBox(width: 14,),
                      (formateTime == null) ? Text('Pick Time',style: TextStyle(fontSize: 16)) : Text(formateTime,style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    if (providerVar.addImage != null) {
                      if (formkey.currentState!.validate()) {
                        var snackbar = SnackBar(content: Text('Submit Successful'));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        ModelClass Data = ModelClass(
                            name: nameController.text,
                            number: numberCotroller.text,
                            chat: chatController.text,
                            Image: providerVar.addImage,
                            Date: formatedDate,
                            Time: formateTime);
                        providerVar.addContactData(Data);
                        nameController.clear();
                        numberCotroller.clear();
                        chatController.clear();
                        providerVar.addImage = null;
                        formatedDate = null;
                        formateTime = null;
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'PickUp Image');
                    }
                  },
                  child: Text('SAVE',style: TextStyle(fontSize: 17),)),
            ]),
          ),
        ),
      ),
    );
  }
}
