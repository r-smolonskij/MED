import 'package:flutter/material.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:med/sqlite/db_helper.dart';
import 'package:med/sqlite/source.dart';
import 'package:provider/provider.dart';

import '../drawer.dart';
class SourcesList extends StatefulWidget {
  @override
  _SourcesListState createState() => _SourcesListState();
}

class _SourcesListState extends State<SourcesList> {
  List<Source> sources = List();
  DBHelper dbHelper = DBHelper();
  void initState() {
    super.initState();
    setState(() {
      dbHelper.getSources().then((sourcesFromDB) {
        setState(() {
          sources = sourcesFromDB;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: languageBloc.isLatvian ? Text('Informācijas avotu saraksts') : Text('List of sources of information'),
      ),
      drawer: MyDrawer(),

      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(
              itemCount: sources.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  shape: BeveledRectangleBorder(
                    side: BorderSide(
                      color: Colors.deepPurple,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          sources[index].source,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
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
