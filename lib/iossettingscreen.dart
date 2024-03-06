import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class iosSettingScreen extends StatefulWidget {
  const iosSettingScreen({super.key});

  @override
  State<iosSettingScreen> createState() => _iosSettingScreenState();
}

class _iosSettingScreenState extends State<iosSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return Column(
      children: [
        CupertinoListTile(
          leading: Icon(CupertinoIcons.person),
          leadingToTitle: 20,
          leadingSize: 40,
          title: Text('Profile'),
          subtitle: Text('Upadate Profile Data'),
          trailing: CupertinoSwitch(
              value: providerVar.getProfile,
              onChanged: (value) {
                providerVar.setProfile = value;
              }),
        ),
        Visibility(
            visible: providerVar.getProfile,
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
                            shape: BoxShape.circle, color: Colors.blue),
                        child: CupertinoButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                CupertinoButton(
                                                    child: Icon(
                                                      Icons.camera,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      providerVar
                                                          .profileCameraImage();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                Text(
                                                  'CAMERA',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                CupertinoButton(
                                                    child: Icon(
                                                      CupertinoIcons
                                                          .photo_on_rectangle,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      providerVar
                                                          .profileAlbumsImage();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                Text('ALBUMS',
                                                    style: TextStyle(
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Icon(
                              CupertinoIcons.camera,
                              size: 34,
                              color: Colors.white,
                            )),
                      ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Enter your name...',
                  textAlign: TextAlign.center,
                  controller: providerVar.proNameController,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Enter your Bio...',
                  textAlign: TextAlign.center,
                  controller: providerVar.proBioController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                        child: Text('SAVE'),
                        onPressed: () {
                          providerVar.proNameSetSharePrefrence(
                              providerVar.proNameController.text);
                          providerVar.setProBioSharePrefrence(
                              providerVar.proBioController.text);
                          providerVar.setImageSharePref(providerVar.proImage);
                          var snackbar = SnackBar(content: Text('SAVE PROFILE DATA'));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }),
                    CupertinoButton(
                        child: Text('CLEAR'),
                        onPressed: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.clear();
                          providerVar.proBioController.clear();
                          providerVar.proNameController.clear();
                          setState(() {
                            providerVar.proImage = null;
                          });
                        }),
                  ],
                ),
              ],
            )),
        Divider(height: 20, endIndent: 20, indent: 20),
        CupertinoListTile.notched(
          leading: Icon(CupertinoIcons.sun_max),
          leadingToTitle: 20,
          leadingSize: 40,
          title: Text('Theme'),
          subtitle: Text('Change Theme'),
          trailing: CupertinoSwitch(
              value: providerVar.getTheme,
              onChanged: (value) {
                providerVar.setTheme = value;
              }),
        ),
      ],
    );
  }
}
