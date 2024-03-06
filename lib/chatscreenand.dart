import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platformconvetor/modelclass.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';

import 'contactaddandroidpage.dart';

class chatScreenAndroid extends StatefulWidget {
  const chatScreenAndroid({super.key});

  @override
  State<chatScreenAndroid> createState() => _chatScreenAndroidState();
}

class _chatScreenAndroidState extends State<chatScreenAndroid> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            child: (providerVar.contactData.isEmpty)
                ? Center(child: Text('No any chats yet...'))
                : ListView.builder(
                    itemCount: providerVar.contactData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        height: 85,
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              shape: OutlineInputBorder(),
                              context: context,
                              builder: (context) {
                                return Container(
                                  width: width,
                                  height: 320,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CircleAvatar(
                                          radius: 60,
                                          backgroundImage: FileImage(providerVar
                                              .contactData[index].Image!),
                                        ),
                                      ),
                                      Text(
                                        providerVar.contactData[index].name!,
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        providerVar.contactData[index].chat!,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  providerVar.editName.text =
                                                      providerVar
                                                          .contactData[index]
                                                          .name!;
                                                  providerVar.editNumber.text =
                                                      providerVar
                                                          .contactData[index]
                                                          .number!;
                                                  providerVar.editChat.text =
                                                      providerVar
                                                          .contactData[index]
                                                          .chat!;
                                                  providerVar.editImage =
                                                      providerVar
                                                          .contactData[index]
                                                          .Image!;
                                                  providerVar.editDate =
                                                      providerVar
                                                          .contactData[index]
                                                          .Date!;
                                                  providerVar.editTime =
                                                      providerVar
                                                          .contactData[index]
                                                          .Time!;
                                                  providerVar.editIndex = index;

                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Container(
                                                          height: 550,
                                                          width: width,
                                                          child: Column(
                                                              children: [
                                                                (providerVar.editImage !=
                                                                        null)
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  content: Container(
                                                                                    width: width - 220,
                                                                                    height: 100,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(top: 8.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                        children: [
                                                                                          Column(
                                                                                            children: [
                                                                                              IconButton(
                                                                                                  onPressed: () {
                                                                                                    providerVar.editAlbumImage();
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                  icon: Icon(
                                                                                                    CupertinoIcons.photo,
                                                                                                    size: 40,
                                                                                                  )),
                                                                                              Text('Albums', style: TextStyle(fontSize: 20)),
                                                                                            ],
                                                                                          ),
                                                                                          Column(
                                                                                            children: [
                                                                                              IconButton(
                                                                                                  onPressed: () {
                                                                                                    providerVar.editCamera();
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                  icon: Icon(
                                                                                                    Icons.camera,
                                                                                                    size: 40,
                                                                                                  )),
                                                                                              Text(
                                                                                                'Camera',
                                                                                                style: TextStyle(fontSize: 20),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        },
                                                                        child:
                                                                            CircleAvatar(
                                                                          radius:
                                                                              60,
                                                                          backgroundImage:
                                                                              FileImage(providerVar.editImage!),
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        height:
                                                                            115,
                                                                        width:
                                                                            115,
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Colors.black12),
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {},
                                                                          icon:
                                                                              Icon(
                                                                            CupertinoIcons.add,
                                                                            size:
                                                                                60,
                                                                            color:
                                                                                Colors.blue,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Name';
                                                                    }
                                                                  },
                                                                  controller:
                                                                      providerVar
                                                                          .editName,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .person_outline_rounded),
                                                                    labelText:
                                                                        'Full Name',
                                                                    border: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            style:
                                                                                BorderStyle.solid,
                                                                            color: Colors.black,
                                                                            width: 4)),
                                                                  ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Number';
                                                                    }
                                                                  },
                                                                  controller:
                                                                      providerVar
                                                                          .editNumber,
                                                                  decoration: InputDecoration(
                                                                      prefixIcon:
                                                                          Icon(Icons
                                                                              .call),
                                                                      labelText:
                                                                          'Phone Number',
                                                                      border: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              style: BorderStyle.solid,
                                                                              color: Colors.black,
                                                                              width: 4))),
                                                                  maxLength: 10,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                                SizedBox(
                                                                  height: 15,
                                                                ),
                                                                TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Enter Chat';
                                                                    }
                                                                  },
                                                                  controller:
                                                                      providerVar
                                                                          .editChat,
                                                                  decoration: InputDecoration(
                                                                      prefixIcon:
                                                                          Icon(Icons
                                                                              .chat_outlined),
                                                                      labelText:
                                                                          'Chat Conversation',
                                                                      border: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              style: BorderStyle.solid,
                                                                              color: Colors.black,
                                                                              width: 4))),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    date = await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        firstDate:
                                                                            DateTime(
                                                                                1990),
                                                                        lastDate:
                                                                            DateTime(
                                                                                3000),
                                                                        initialDate:
                                                                            DateTime.now());
                                                                    print(date);
                                                                    if (date !=
                                                                        null) {
                                                                      setState(
                                                                          () {
                                                                        formatedDate = (date !=
                                                                                null)
                                                                            ? DateFormat('dd/MM/yyyy').format(date)
                                                                            : providerVar.editDate;
                                                                      });
                                                                    }
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(Icons
                                                                            .date_range_outlined),
                                                                        (formatedDate ==
                                                                                null)
                                                                            ? Text(
                                                                                providerVar.editDate,
                                                                                style: TextStyle(fontSize: 14),
                                                                              )
                                                                            : Text(
                                                                                formatedDate,
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    time = await showTimePicker(
                                                                        context:
                                                                            context,
                                                                        initialTime:
                                                                            TimeOfDay.now());
                                                                    print(time
                                                                        .format(
                                                                            context));
                                                                    if (time !=
                                                                        null) {
                                                                      datepicker = DateTime(
                                                                          DateTime.now()
                                                                              .year,
                                                                          DateTime.now()
                                                                              .month,
                                                                          DateTime.now()
                                                                              .day,
                                                                          time.hour,
                                                                          time.minute);
                                                                      setState(
                                                                          () {
                                                                        formateTime = (datepicker !=
                                                                                null)
                                                                            ? DateFormat('HH:mm').format(datepicker)
                                                                            : providerVar.editTime;
                                                                      });

                                                                      print(
                                                                          formateTime);
                                                                    }
                                                                  },
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(Icons
                                                                            .access_time),
                                                                        (formateTime ==
                                                                                null)
                                                                            ? Text(
                                                                                providerVar.editTime,
                                                                                style: TextStyle(fontSize: 14),
                                                                              )
                                                                            : Text(
                                                                                formateTime,
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    OutlinedButton(
                                                                        onPressed:
                                                                            () {
                                                                          ModelClass
                                                                              edit =
                                                                              ModelClass(
                                                                            name:
                                                                                providerVar.editName.text,
                                                                            number:
                                                                                providerVar.editNumber.text,
                                                                            chat:
                                                                                providerVar.editChat.text,
                                                                            Image:
                                                                                providerVar.editImage,
                                                                            Date: (formatedDate == null)
                                                                                ? providerVar.editDate
                                                                                : formatedDate,
                                                                            Time: (formateTime == null)
                                                                                ? providerVar.editTime
                                                                                : formateTime,
                                                                          );
                                                                          providerVar.editContactData(
                                                                              edit,
                                                                              index);

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          providerVar.editImage =
                                                                              null;
                                                                          providerVar.editTime =
                                                                              null;
                                                                          providerVar.editDate =
                                                                              null;
                                                                        },
                                                                        child: Text(
                                                                            'EDIT')),
                                                                    OutlinedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            'CANCEL'))
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 34,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  providerVar
                                                      .deleteContactData(index);
                                                  //setState(() {
                                                  Navigator.of(context).pop();
                                                  //});
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 34,
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: FileImage(
                                providerVar.contactData[index].Image!),
                          ),
                          title: Text(
                            providerVar.contactData[index].name!,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            providerVar.contactData[index].chat!,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          trailing: Container(
                            width: 120,
                            child: Row(
                              children: [
                                Text(
                                  providerVar.contactData[index].Date
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(', '),
                                Text(
                                  providerVar.contactData[index].Time
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
