import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingAndroid extends StatefulWidget {
  const settingAndroid({super.key});

  @override
  State<settingAndroid> createState() => _settingAndroidState();
}

class _settingAndroidState extends State<settingAndroid> {


  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context,listen: true);

    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            subtitle: Text('Upadate Profile Data'),
            trailing: Switch(
                onChanged: (value) {
                  providerVar.setProfile = value;
                },
                value: providerVar.getProfile),
          ),
          Visibility(
            child: Column(
              children: [
                (providerVar.proImage != null)
                    ? CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(providerVar.proImage!),
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
                                    IconButton(onPressed: (){ providerVar.profileAlbumsImage();
                                    Navigator.of(context).pop();}, icon: Icon(CupertinoIcons.photo,size: 40,)),
                                    Text('Albums',style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(onPressed: (){ providerVar.profileCameraImage();
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
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: providerVar.proNameController,
                  decoration: InputDecoration(border: InputBorder.none,hintText: 'Enter your name...'),
                ),
                TextFormField(  textAlign: TextAlign.center,
                  controller: providerVar.proBioController,
                  decoration: InputDecoration(border: InputBorder.none,hintText: 'Enter your Bio...'),  ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    TextButton(onPressed: ()  {
                           providerVar.proNameSetSharePrefrence(providerVar.proNameController.text);
                           providerVar.setProBioSharePrefrence(providerVar.proBioController.text);
                           providerVar.setImageSharePref(providerVar.proImage);
                           var snackbar = SnackBar(content: Text('SAVE PROFILE DATA'));
                           ScaffoldMessenger.of(context).showSnackBar(snackbar);

      
                    }, child: Text('SAVE')),
                    TextButton(onPressed: () async {
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.clear();
                      providerVar.proBioController.clear();

                      providerVar.proNameController.clear();
                      setState(() {
                        providerVar.proImage = null;
                      });
      
                    }, child: Text('CLEAR')),
                  ],),
                )
              ],
            ),
            visible: providerVar.proData,
          ),
          Divider(height: 20,endIndent: 20,indent: 20),
          ListTile(
              leading: Icon(CupertinoIcons.sun_max),
              title: Text('Theme'),
              subtitle: Text('Change Theme'),
              trailing: Switch(
                  value: providerVar.getTheme,
                  onChanged: (value) {
                    providerVar.setTheme = value;
                  })),
        ],
      ),
    );
  }
}
