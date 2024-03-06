import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platformconvetor/callsandroid.dart';
import 'package:platformconvetor/chatscreenand.dart';
import 'package:platformconvetor/contactaddandroidpage.dart';
import 'package:platformconvetor/cupertinopage.dart';
import 'package:platformconvetor/platformprovider.dart';
import 'package:platformconvetor/settingandroid.dart';
import 'package:provider/provider.dart';



int index = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => platformProvider())
      ],
      child: Consumer<platformProvider>(builder: (context, theme, child) {
        return (theme.isPlatform == true)
            ? CupertinoApp(
                theme: (theme.isTheme == false)
                    ? CupertinoThemeData(
                        barBackgroundColor: Colors.white,
                        brightness: Brightness.light)
                    : CupertinoThemeData(
                        barBackgroundColor: Colors.black,
                        brightness: Brightness.dark),
                debugShowCheckedModeBanner: false,
                home: CupertionPage(),
              )
            : MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: (theme.isTheme == false)
                    ? ThemeData(
                        colorScheme:
                            ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                        useMaterial3: true,
                      )
                    : ThemeData.dark(useMaterial3: true),
                home: const MyHomePage(title: 'Flutter Demo Home Page'),
              );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<platformProvider>(context,listen: true);

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Platform Converter'),
            actions: [
              Switch(
                  value: providerVar.getPlatform,
                  onChanged: (value) {
                    providerVar.setPlatform = value;
                  })
            ],
            bottom: TabBar(labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),tabs: [
              Tab(
                icon: Icon(Icons.person_add_alt_outlined),
              ),
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'CALLS',
              ),
              Tab(
                text: 'SETTINGS',
              )
            ]),
          ),
          body: TabBarView(children: [
            contactAddAndroid(),
            chatScreenAndroid(),
            callsAndroid(),
            settingAndroid()
          ]),
        ));
  }
}
