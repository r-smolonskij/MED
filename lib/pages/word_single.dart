import 'package:flutter/material.dart';
import 'package:med/sqlite/database_helper.dart';
import 'package:med/sqlite/db_helper.dart';
import 'package:med/sqlite/field.dart';
import 'package:med/sqlite/word.dart';
import 'package:expandable/expandable.dart';
import 'field_single.dart';

class WordSingle extends StatefulWidget {
  final int id;
  WordSingle(this.id);

  @override
  _WordSingleState createState() => _WordSingleState();
}

class _WordSingleState extends State<WordSingle> {
  List<Field> relatedFields = List();
  List<Widget> relatedFieldsWidget = List();
  Word foundedWord;
  String wordType;
  String article = "Description Line 1Description Line 2nDescription Line 3nDescription Line 4nDescription Line 5\nDescription Line 6\nDescription Line 7\nDescription Line 8";

  Future<Word> _getWord() async {
    var word = await dbHelper2.getWordByID(widget.id);
    return word;
  }

  Future<List<Field>> _getRelatedFields() async {
    List<Field> fields = await dbHelper2.getFieldsByWordID(widget.id);
    return fields;
  }

  Widget returnField(Field field){
    return Text(field.fieldLV);
  }
  void returnFields(){
    for( var i = 0 ; i < relatedFields.length; i++ ) {

      relatedFieldsWidget.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RaisedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FieldSingle(relatedFields[i].fieldID))),
              elevation: 2.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              icon: Icon(Icons.open_in_new),
              label: Text(relatedFields[i].fieldLV,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        // new Text(relatedFields[i].titleLV)
      );

    }
  }

  String getWordType(int typeID) {
    if (typeID == 1) {
      return 'Jautājums';
    } else if (typeID == 2) {
      return 'Vārds2';
    } else if (typeID == 3) {
      return 'Vārds3';
    }
  }

  int id;
  Word word;
  //DBHelper dbHelper = DBHelper();
  DBHelper dbHelper2 = DBHelper();

  List<Field> fields = List();

  void initState() {
    super.initState();
    setState(() {
      dbHelper2.getWordByID(widget.id).then((word) {
        setState(() {
          foundedWord = word;
        });
      });
      dbHelper2.getFieldsByWordID(widget.id).then((fieldsFromDB) {
        setState(() {
          relatedFields = fieldsFromDB;
          returnFields();
        });
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text(''+word.wordLV),
          ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(
                foundedWord.wordLV,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                wordType,
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
                  RaisedButton.icon(
                    onPressed: () {},
                    elevation: 2.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                    ),
                    color: Colors.white,
                    icon: Icon(Icons.volume_up),
                    label: Text("Latviski",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 50.0,),
                ],
              ),
              SizedBox(height: 15.0,),
              Text(
                "LV: " + foundedWord.wordLV,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                "ENG: " + foundedWord.wordENG,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 25.0,),
              ExpandablePanel(
//                header: Row(
//                  children: <Widget>[
//                    Text('Lasīt vairāk ', style: TextStyle(fontSize: 18.0)),
//                    Icon(Icons.arrow_downward),
//                  ],
//                ),
                collapsed: Row(
                  children: <Widget>[
                    Text('Lasīt vairāk ', style: TextStyle(fontSize: 18.0)),
                    Icon(Icons.arrow_downward),
                  ],
                ),
                expanded: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Lasīt mazāk ', style: TextStyle(fontSize: 18.0)),
                        Icon(Icons.arrow_upward),
                      ],
                    ),

                        Text( article, softWrap: true, ),
                  ],
                ),
                tapHeaderToExpand: true,
                hasIcon: false,
                tapBodyToCollapse: true,
              ),
              Column(
                children: relatedFieldsWidget,
              )

            ],
          ),
        ),
      ),
    );
  }
}
