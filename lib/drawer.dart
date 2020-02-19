import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:med/pages/fields.dart';
import 'package:med/pages/games_list.dart';
import 'package:med/pages/information.dart';
import 'package:med/pages/grammar.dart';
import 'package:med/pages/search.dart';
import 'package:med/pages/sources.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/bg.jpeg"),
                  fit: BoxFit.cover),
            ),
            accountName: new Text('MED', style: TextStyle(fontSize: 100.0, height: -40.0, color: Colors.black),),
          ),
          new ListTile(
            leading: Icon(FontAwesomeIcons.home),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Sākums') : new Text('Home'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => SearchPage(),
              ),),
            },
          ),

          new Divider(),
          new ListTile(
            leading: Icon(FontAwesomeIcons.infoCircle),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Informācija par MED') : new Text('Info about MED'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => InformationPage(),
              ),),
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(FontAwesomeIcons.medkit),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Medicīnas nozares') : new Text('Fields of Medicine'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => FieldsPage(),
              ),),
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(FontAwesomeIcons.book),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Avotu saraksts') : new Text('List of sources of information'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => SourcesList(),
              ),),
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(FontAwesomeIcons.gamepad),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Izglītojošas spēles') : new Text('Educational games') ,
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => GamesList(),
              ),),
            },
          ),
          new Divider(),
          new ListTile(
            leading: Icon(FontAwesomeIcons.pen),
            trailing: new Icon(Icons.arrow_forward_ios),
            title: languageBloc.isLatvian ? new Text('Latviešu gramatikas pārskats') : new Text('Review of Latvian Grammar') ,
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => GrammarPage(),
              ),),
            },
          ),
          new Divider(),
          SwitchListTile(
            title: languageBloc.isLatvian ? Text('Latviski') : Text('English'),
            value: languageBloc.isLatvian,
            onChanged: (bool value) { setState(() { languageBloc.isLatvian = value;}); },
            secondary: const Icon(Icons.language),
          ),
        ],
      ),
    );
  }
}
