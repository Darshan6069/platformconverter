import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconvetor/iosaddcontact.dart';
import 'package:platformconvetor/ioscallscreen.dart';
import 'package:platformconvetor/ioschatscreen.dart';
import 'package:platformconvetor/iossettingscreen.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:provider/provider.dart';

class CupertionPage extends StatefulWidget {
  const CupertionPage({super.key});

  @override
  State<CupertionPage> createState() => _CupertionPageState();
}

List<Widget> tabList = [
  iosContactAdd(),
  iosChatScreen(),
  iosCallScreen(),
  iosSettingScreen()
];

class _CupertionPageState extends State<CupertionPage> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Platform Converter'),
          trailing: CupertinoSwitch(
              value: providerVar.getPlatform,
              onChanged: (value) {
                providerVar.setPlatform = value;
              })),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add_solid)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2),label: 'CHATS'),
          BottomNavigationBarItem(icon: Icon(Icons.call),label: 'CALLS'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings),label: 'SETTINGS'),
        ]),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return Center(child: tabList[index]);
            },
          );
        },
      ),
    );
  }
}
