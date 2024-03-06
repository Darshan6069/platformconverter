import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';

import 'contactaddandroidpage.dart';
import 'modelclass.dart';

class iosChatScreen extends StatefulWidget {
  const iosChatScreen({super.key});

  @override
  State<iosChatScreen> createState() => _iosChatScreenState();
}

class _iosChatScreenState extends State<iosChatScreen> {
  var iosTime;
  var iosDate;
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            child: (providerVar.contactData.isEmpty)?Center(child: Text('No any chats yet...')):ListView.builder(
              itemCount: providerVar.contactData.length,
              itemBuilder: (context, index) {
                return CupertinoListTile(

                  onTap: (){
                    showCupertinoModalPopup(context: context, builder: (context) {
                      return Container(
                        height: 340,
                        width: width,
                        color: (providerVar.isTheme==false)?Colors.white:Colors.black,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 65,
                                backgroundImage: FileImage(
                                    providerVar.contactData[index].Image!),
                              ),
                            ),

                            Text(providerVar.contactData[index].name!,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                            SizedBox(height: 6,),
                            Text(providerVar.contactData[index].chat!,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                            SizedBox(height: 6,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(child: Icon(Icons.edit,size: 30,), onPressed: (){

                                  Navigator.of(context).pop();
                                  providerVar.editName.text = providerVar
                                      .contactData[index].name!;
                                  providerVar.editNumber.text = providerVar
                                      .contactData[index].number!;
                                  providerVar.editChat.text = providerVar
                                      .contactData[index].chat!;
                                  providerVar.editImage = providerVar
                                      .contactData[index].Image!;
                                  providerVar.editDate = providerVar
                                      .contactData[index].Date!;
                                  providerVar.editTime = providerVar
                                      .contactData[index].Time!;
                                  providerVar. editIndex = index;


                                  showCupertinoDialog(context: context, builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Container(
                                        height: 420,
                                        width: width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            (providerVar.editImage != null)
                                                ? GestureDetector(
                                              onTap: (){
                                                showCupertinoDialog(context: context, builder: (context){
                                                  return CupertinoAlertDialog(content: Container(
                                                    width: width-220,
                                                    height: 100,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              IconButton(onPressed: (){ providerVar.editAlbumImage();
                                                              Navigator.of(context).pop();}, icon: Icon(CupertinoIcons.photo,size: 40,)),
                                                              Text('Albums',style: TextStyle(fontSize: 20)),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              IconButton(onPressed: (){ providerVar.editCamera();
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
                                                  child: CircleAvatar(
                                                                                                  radius: 60,
                                                                                                  backgroundImage:
                                                                                                  FileImage(
                                                    providerVar.editImage!),
                                                                                                ),
                                                )
                                                : Container(
                                              height: 115,
                                              width: 115,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape
                                                      .circle,
                                                  color: Colors
                                                      .black12),
                                              child: CupertinoButton(
                                                onPressed: () {
                                                  providerVar
                                                      .getAlbumsImage();
                                                },
                                                child: Icon(
                                                  CupertinoIcons
                                                      .add,
                                                  size: 60,
                                                  color: Colors
                                                      .blue,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            CupertinoTextFormFieldRow(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter Name';
                                                }
                                              },
                                              controller: providerVar.editName,
                                              prefix: Icon(
                                                Icons.person_outline_outlined,
                                                size: 30,
                                              ),
                                              placeholder: 'Full Name',
                                              keyboardType: TextInputType.text,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1,color: (providerVar.isTheme==false)? Colors.black38:Colors.white38),
                                                  borderRadius: BorderRadiusDirectional.circular(6)),
                                            ),
                                            CupertinoTextFormFieldRow(


                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter Number';
                                                }
                                              },
                                              controller: providerVar.editNumber,

                                              prefix: Icon(
                                                CupertinoIcons.phone,
                                                size: 30,
                                              ),
                                              placeholder: 'Phone Number',
                                              keyboardType: TextInputType.number,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1,color: (providerVar.isTheme==false)? Colors.black38:Colors.white38),
                                                  borderRadius: BorderRadiusDirectional.circular(6)),
                                            ),
                                            CupertinoTextFormFieldRow(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter Chat';
                                                }
                                              },
                                              controller: providerVar.editChat,
                                              prefix: Icon(
                                                CupertinoIcons.chat_bubble_text,
                                                size: 30,
                                              ),
                                              placeholder: 'Chat Conversation',
                                              keyboardType: TextInputType.text,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1,color: (providerVar.isTheme==false)? Colors.black38:Colors.white38),
                                                  borderRadius: BorderRadiusDirectional.circular(6)),
                                            ),
                                            SizedBox(height: 6,),
                                            GestureDetector(
                                              onTap: () {
                                                showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                        height: 300,
                                                        color: Colors.white,
                                                        child: CupertinoDatePicker(
                                                          onDateTimeChanged: (DateTime value) {
                                                            setState(() {
                                                              iosDate = DateFormat('dd/MM/yyyy').format(value);
                                                            });
                                                          },
                                                          mode: CupertinoDatePickerMode.date,
                                                          use24hFormat: false,
                                                          initialDateTime: DateTime.now(),
                                                        ));
                                                  },
                                                );
                                                print(iosDate);
                                              },
                                              child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 19.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(CupertinoIcons.calendar,size: 30,),
                                                      SizedBox(width: 10,),
                                                      (iosDate != null)
                                                          ? Text(iosDate.toString(),style: TextStyle(fontSize: 17),)
                                                          : Text(providerVar.editDate,style: TextStyle(fontSize: 17))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) {
                                                    return Container(
                                                        height: 300,
                                                        color: Colors.white,
                                                        child: CupertinoDatePicker(
                                                          onDateTimeChanged: (DateTime value) {
                                                            setState(() {
                                                              iosTime = DateFormat('HH:mm').format(value);
                                                            });
                                                          },
                                                          mode: CupertinoDatePickerMode.time,
                                                          use24hFormat: false,
                                                          initialDateTime: DateTime.now(),
                                                        ));
                                                  },
                                                );
                                                print(iosTime);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 19.0),
                                                child: Row(
                                                  children: [
                                                    Icon(CupertinoIcons.time,size: 30,),
                                                    SizedBox(width: 13,),
                                                    (iosTime != null) ? Text(iosTime.toString(),style: TextStyle(fontSize: 17),) : Text(providerVar.editTime,style: TextStyle(fontSize: 17),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                OutlinedButton(
                                                    onPressed: () {
                                                      ModelClass edit =
                                                      ModelClass(
                                                        name: providerVar.editName.text,
                                                        number: providerVar.editNumber.text,
                                                        chat:providerVar.editChat.text,
                                                        Image: providerVar.editImage,
                                                        Date: (iosDate == null)?providerVar.editDate:iosDate,
                                                        Time: (iosTime == null)?providerVar.editTime:iosTime,
                                                      );
                                                      providerVar.editContactData(edit, index);

                                                        Navigator.of(context).pop();
                                                      providerVar.editImage=null;
                                                      providerVar.editTime=null;
                                                      providerVar.editDate=null;
                                                    },
                                                    child:
                                                    Text('EDIT')),
                                                OutlinedButton(child: Text('CANCEL'), onPressed: (){Navigator.of(context).pop();})
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ),

                                    );
                                  },);

                                }),
                                CupertinoButton(child: Icon(Icons.delete,size: 30,), onPressed: (){
                                  providerVar.deleteContactData(index);
                                  Navigator.of(context).pop();
                                }),

                              ],
                            ),
                            SizedBox(height: 5,),

                            CupertinoButton(color:(providerVar.isTheme==false)?Colors.black38:Colors.white38,child: Text('Cancel'), onPressed: (){Navigator.of(context).pop();})
                          ],
                        ),
                      );
                    },);
                  },
                  leadingSize: 60,
                  leadingToTitle: 20,
                  padding: EdgeInsets.all(5),
                  title: Text(providerVar.contactData[index].name!,style: TextStyle(fontSize: 18),),
                  subtitle: Text(providerVar.contactData[index].chat!,style: TextStyle(fontSize: 16),),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        FileImage(providerVar.contactData[index].Image!),
                  ),
                  trailing: Container(
                    width: 140,
                    child: Row(
                      children: [
                        Text(providerVar.contactData[index].Date.toString()),
                        Text(', '),
                        Text(providerVar.contactData[index].Time.toString()),
                      ],
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
