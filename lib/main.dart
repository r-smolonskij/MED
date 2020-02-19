import 'dart:wasm';
import 'package:med/blocs/language_bloc.dart';
import 'package:med/pages/search.dart';
//import 'package:med/sqlite/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:med/sqlite/database_helper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageBloc>.value(
          value: LanguageBloc(),
        ),
      ],
      child: MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: new SearchPage(),
        routes: <String, WidgetBuilder>{
          '/searchPage': (BuildContext context) => new SearchPage(),
       }
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper2 = DatabaseHelper();
  void initState(){
    super.initState();
//    dbHelper2.getFieldsCount().then((count) {
//      setState(() {
//       if(count > 0){
//         print('Lielāks par 0');
//         print(count);
//       }
//       else{
//         print('Mazāks par 0');
//       }
//      });
//    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('MED App'),
      ),
      drawer: MyDrawer(),
    );
  }
}

