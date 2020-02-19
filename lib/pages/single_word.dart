import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med/sqlite/database_helper.dart';
import 'package:med/sqlite/db_helper.dart';
import 'package:med/sqlite/definition.dart';
import 'package:med/sqlite/field.dart';
import 'package:med/sqlite/word.dart';
import 'package:expandable/expandable.dart';
import 'field_single.dart';
import 'package:flutter/widgets.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:provider/provider.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class SingleWord extends StatefulWidget {
  final int wordID;
  SingleWord(this.wordID);

  @override
  _SingleWordState createState() => _SingleWordState();
}

class _SingleWordState extends State<SingleWord> {
  Word word;
  //AssetsAudioPlayer _assetsAudioPlayer;
  //DatabaseHelper dbHelper = DatabaseHelper();
  DBHelper dbHelper = DBHelper();
  List<Field> foundedFields;
  List<Widget> relatedFieldsWidget = List();
  int wordType;
  Definition definition = new Definition(0, "", "", "", "", "");
  String definitionURL='';
  String example;

  Future<Word> _getWord() async {

    word = await dbHelper.getWordByID(widget.wordID);
    List<Field> fields = await dbHelper.getFieldsByWordID(widget.wordID);
    var defCount = await dbHelper.getDefinitionCount(widget.wordID);
    if(defCount>0){
      definition = await dbHelper.getDefinitionByWordID(widget.wordID);
      definitionURL = definition.definitionSourceLink;
    }

    return word;
  }

  Future<bool> myLoadAsset(int id) async {
    return rootBundle.load('assets/audios/$id.mp3').then((value) {
      return true;
    }).catchError((_) {
      return null;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
    setState(() {
      dbHelper.getFieldsByWordID(widget.wordID).then((fieldsFromDB) {
        setState(() {
          foundedFields = fieldsFromDB;
          returnFields();
        });
      });
    });
  }

  void returnFields() {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);

    for (var i = 0; i < foundedFields.length; i++) {
      relatedFieldsWidget.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RaisedButton.icon(
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              icon: Icon(Icons.open_in_new),
              label: Expanded(
                child: Text(
                  languageBloc.isLatvian
                      ? foundedFields[i].fieldLV
                      : foundedFields[i].fieldENG,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FieldSingle(foundedFields[i].fieldID))),
            ),
          ),
        ),
      );
    }
  }

  String returnWordType(String type) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    if (type == 'J') {
      return languageBloc.isLatvian ? 'Jautājums' : 'Question';
    } else if (type == 'N') {
      return languageBloc.isLatvian ? 'Norādījums' : 'Instruction';
    } else if (type == 'V') {
      return languageBloc.isLatvian ? 'Vārds' : 'Word';
    } else {
      return '';
    }
  }

  _launchURL() async {
    if (await canLaunch(definitionURL)) {
      await launch(definitionURL);
    } else {
      throw 'Could not launch $definitionURL';
    }
    return true;
  }

  Widget definitionWidget(String definition, String source) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    if (definition != '') {
      return Column(
        children: <Widget>[
          ExpandablePanel(
            collapsed: Row(
              children: <Widget>[
                Text(languageBloc.isLatvian ? 'Apskatīt definīciju ' : 'Open definition ', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_downward),
              ],
            ),
            expanded: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(languageBloc.isLatvian ? 'Aizvērt definīciju ' : 'Close definition ', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_upward),
                  ],
                ),
                Text(
                  definition,
                  style: TextStyle(fontSize: 15.0),
                  softWrap: true,
                ),
                RaisedButton.icon(
                  elevation: 2.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  color: Colors.deepPurple,
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                  ),
                  label: Expanded(
                    child: Text(
                      source,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onPressed: _launchURL,
                ),
              ],
            ),
            tapHeaderToExpand: true,
            hasIcon: false,
            tapBodyToCollapse: true,
          ),
          SizedBox(height: 20,),
        ],
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget exampleWidget(String example, String source) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    if (example != '') {
      return Column(
        children: <Widget>[
          ExpandablePanel(
            collapsed: Row(
              children: <Widget>[
                Text(languageBloc.isLatvian ? 'Apskatīt piemēru ' : 'Open example ', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_downward),
              ],
            ),
            expanded: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(languageBloc.isLatvian ? 'Aizvērt piemēru ' : 'Close example ' , style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), ),
                    Icon(Icons.arrow_upward),
                  ],
                ),
                Text(
                  example,
                  style: TextStyle(fontSize: 15.0),
                  softWrap: true,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '-' + source,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                )
              ],
            ),
            tapHeaderToExpand: true,
            hasIcon: false,
            tapBodyToCollapse: true,
          ),
          SizedBox(
            height: 20,
          )
        ],
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initPlayer(){
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState((){
      _duration = d;
    });
    advancedPlayer.positionHandler = (p) => setState((){
      _position = p;
    });
    advancedPlayer.stop();
  }
  void playSound(int soundNumber){
      audioCache.play('audios/$soundNumber.mp3');
  }
  @override
  void dispose() {
    advancedPlayer.stop();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: _getWord(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        languageBloc.isLatvian
                            ? snapshot.data.wordLV
                            : snapshot.data.wordENG,
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        returnWordType(snapshot.data.wordType),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          FutureBuilder(
                              future: myLoadAsset(widget.wordID),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: SizedBox(
                                        height: 0,
                                      ),
                                    ),
                                  );
                                } else {
                                  return RaisedButton.icon(
                                    onPressed: () {
//                                      audioCache.play('/audios/1.mp3');
                                     playSound(widget.wordID);
                                    },
                                    elevation: 2.0,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                    ),
                                    color: Colors.white,
                                    icon: Icon(Icons.volume_up),
                                    label: Text(
                                      "Latviski",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }
                              }),
                          SizedBox(
                            width: 50.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "LV: " + snapshot.data.wordLV,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "ENG: " + snapshot.data.wordENG,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      definition.definition!=null ? definitionWidget(
                         definition.definition, definition.definitionSource) : SizedBox(height: 0,),

                      definition.example!=null ? exampleWidget(definition.example,
                         definition.exampleSource) : SizedBox(height: 0,),
                      Column(
                        children: relatedFieldsWidget,
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
