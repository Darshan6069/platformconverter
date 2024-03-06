import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';
import 'modelclass.dart';

class iosContactAdd extends StatefulWidget {
  const iosContactAdd({super.key});

  @override
  State<iosContactAdd> createState() => _iosContactAddState();
}

class _iosContactAddState extends State<iosContactAdd> {
  TextEditingController nameIosController = TextEditingController();
  TextEditingController numberIosCotroller = TextEditingController();
  TextEditingController chatIosController = TextEditingController();

  var iosDate;
  var iosTime;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return Form(
      key: formkey,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:  (providerVar.addImage != null)?CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(providerVar.addImage!),
                    )
                : Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                    child: CupertinoButton(
                        child: Icon(CupertinoIcons.camera,
                        size: 36,color: Colors.white,),
                        onPressed: () {
                         showCupertinoModalPopup(context: context, builder: (context){
                           return CupertinoAlertDialog(
                             content: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 Container(
                                   child: Column(
                                     children: [
                                       CupertinoButton(child: Icon(Icons.camera,size: 35,), onPressed: (){
                                         providerVar.getCameraImage();
                                         Navigator.of(context).pop();
                                       }),
                                       Text('CAMERA',style: TextStyle(fontSize: 18),),
                                     ],
                                   ),
                                 ),
                                 Container(
                                   child: Column(
                                     children: [
                                       CupertinoButton(child: Icon(CupertinoIcons.photo_on_rectangle,size: 35,  ), onPressed: (){
                                         providerVar.getAlbumsImage();
                                         Navigator.of(context).pop();
                                       }),
                                       Text('ALBUMS',style: TextStyle(fontSize: 18)),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           );
                         });
                        }))),
            SizedBox(height: 15,),
            CupertinoTextFormFieldRow(

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Name';
                }
              },
              controller: nameIosController,
              padding: EdgeInsets.zero,
              prefix: Icon(
                Icons.person_outline_outlined,
                size: 30,
              ),

              placeholder: 'Full Name  ',
              keyboardType: TextInputType.text,
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color:(providerVar.isTheme==false)? Colors.black38:Colors.white38),
                  borderRadius: BorderRadiusDirectional.circular(6)),
            ),
            SizedBox(height: 15,),

            CupertinoTextFormFieldRow(

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Number';
                }
              },
              controller: numberIosCotroller,
              padding: EdgeInsets.zero,
              prefix: Icon(
                CupertinoIcons.phone,
                size: 30,
              ),
              placeholder: 'Phone Number',
              keyboardType: TextInputType.number,
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color:(providerVar.isTheme==false)? Colors.black38:Colors.white38),
                  borderRadius: BorderRadiusDirectional.circular(6)),
            ),
            SizedBox(height: 15,),

            CupertinoTextFormFieldRow(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Chat';
                }
              },
              controller: chatIosController,
              padding: EdgeInsets.zero,
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
            SizedBox(height: 15,),

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
                child: Row(
                  children: [
                    Icon(CupertinoIcons.calendar,size: 30,),
                    SizedBox(width: 7,),
                    (iosDate != null)
                        ? Text(iosDate.toString())
                        : Text('PickDate')
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
              child: Row(
                children: [
                  Icon(CupertinoIcons.time,size: 30,),
                  SizedBox(width: 7,),
                  (iosTime != null) ? Text(iosTime.toString()) : Text('PickTime')
                ],
              ),
            ),
            SizedBox(height: 15,),
            CupertinoButton(
                onPressed: () {
                  if (providerVar.addImage != null) {
                     if (formkey.currentState!.validate()) {

                      ModelClass Data = ModelClass(
                          name: nameIosController.text,
                          number: numberIosCotroller.text,
                          chat: chatIosController.text,
                          Image: providerVar.addImage,
                          Date: iosDate,
                          Time: iosTime);
                      providerVar.addContactData(Data);
                      nameIosController.clear();
                      numberIosCotroller.clear();
                      chatIosController.clear();
                      providerVar.addImage = null;
                      iosDate = null;
                      iosTime = null;
                      var snackbar = SnackBar(content: Text('ADD SUCCESSFUL'));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                     }
                  } else {
                    Fluttertoast.showToast(msg: 'PickUp Image');
                  }
                },color: Colors.blue,
              child: Text('SAVE'),)
          ],
        ),
      ),
    );
  }
}
