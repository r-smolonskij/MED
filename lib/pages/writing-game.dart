import 'package:flutter/material.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:med/sqlite/database_helper.dart';
import 'package:med/sqlite/db_helper.dart';
import 'package:med/sqlite/field.dart';
import 'package:med/sqlite/word.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';

class WritingGame extends StatefulWidget {
  final int fieldID;
  WritingGame(this.fieldID);

  @override
  _WritingGameState createState() => _WritingGameState();
}

class _WritingGameState extends State<WritingGame> {

 String wordType = '';
  Future<Word> _getRandomWord() async {
    if (canChangeWord) {
      var rng = new Random();
      //Field field = await dbHelper.getFieldByID(widget.fieldID);
      List<Word> words = await dbHelper.getWordsByFieldID(widget.fieldID);
      randomWord = await dbHelper.getWordByID(words[rng.nextInt(words.length)].wordID);
      wordType = randomWord.wordType;
      canChangeWord = false;
      //wordType = await dbHelper.getWordTypeByWordID(randomWord.wordID);
    }
    return randomWord;
  }
  bool canChangeWord = true;
  int randomNumber = 0;
  Field field;
  //DatabaseHelper dbHelper = DatabaseHelper();
  DBHelper dbHelper = DBHelper();
  Word randomWord;
  @override
  Widget instructionText(Word word, int type) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);

    return Column(
      children: <Widget>[
        word.wordType == 'V' ? Text(
            languageBloc.isLatvian ?
            'Uzrakstiet šo vārdu/frāzi angļu valodā' :
            'Write this word/phrase in Latvian',
            style: TextStyle(
              fontSize: 33.0,
            ),
          ): SizedBox(height: 0,),
        word.wordType == 'J' ? Text(
          languageBloc.isLatvian ?
          'Uzrakstiet šo jautājumu angļu valodā':
          'Write this question in Latvian',
          style: TextStyle(
            fontSize: 33.0,
          ),
        ): SizedBox(height: 0,),
        word.wordType == 'N' ? Text(
          languageBloc.isLatvian ?
          'Uzrakstiet šo norādījumu angļu valodā' :
          'Write this instruction in Latvian',
          style: TextStyle(
            fontSize: 33.0,
          ),
        ): SizedBox(height: 0,),
        word.wordType == '' ? Text(
          languageBloc.isLatvian ?
          'Uzrakstiet šo angļu valodā' :
          'Write this in Latvian',
          style: TextStyle(
            fontSize: 33.0,
          ),
        ): SizedBox(height: 0,),
        Divider(
          height: 20,
          color: Colors.blueGrey,
          thickness: 2,
        ),
        Text(
          languageBloc.isLatvian ?
          '"' + word.wordLV + '"' :
          '"' + word.wordENG + '"',
          style: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );

  }

  Future<bool> checkAnswer(String answer, Word word) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    String correctAnswer = languageBloc.isLatvian ? word.wordENG.replaceAll(new RegExp("\\(.*?\\)"), "") : word.wordLV.replaceAll(new RegExp("\\(.*?\\)"), "");
    if (answer.toLowerCase() == correctAnswer.toLowerCase()) {
      return Alert(
        context: context,
        title: languageBloc.isLatvian ? "Pareizi" : 'Correct Answer',
        type: AlertType.success,
        style: AlertStyle(
          animationType: AnimationType.fromTop,
          isCloseButton: false,
        ),
        buttons: [
          DialogButton(
            child: Text(
              languageBloc.isLatvian ? "NĀKOŠAIS" : 'NEXT',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            //onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WritingGame(widget.fieldID))),
            onPressed: () {
              setState(() {
                canChangeWord = true;
                answerController.text = '';
                Navigator.pop(context);
              });
            },
          )
        ],
      ).show();
    } else {
      return Alert(
        context: context,
        title: languageBloc.isLatvian ? "Nepareizi" : 'Wrong Answer',
        type: AlertType.error,
        desc: languageBloc.isLatvian
            ? 'Pareizā atbilde: ' + correctAnswer
            : 'Correct answer: ' + correctAnswer,
        style: AlertStyle(
          animationType: AnimationType.fromTop,
          isCloseButton: false,
        ),
        buttons: [
          DialogButton(
            child: Text(
              languageBloc.isLatvian ? "NĀKOŠAIS" : 'NEXT',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                canChangeWord = true;
                answerController.text = '';
                Navigator.pop(context);
              });
            },
            //onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WritingGame(widget.fieldID))),
          )
        ],
      ).show();
    }
  }

  TextEditingController answerController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: languageBloc.isLatvian
            ? Text('"Uzraksti pareizi"')
            : Text('Writing Game'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getRandomWord(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return Container(
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: instructionText(snapshot.data, 20001),
                    ),
                    TextField(
                      controller: answerController,
                      autofocus: false,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        focusColor: Colors.deepPurple,
                        hintText: languageBloc.isLatvian
                            ? 'Ievadiet šeit atbildi'
                            : 'Enter here answer',
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        prefixIcon: Icon(Icons.add_box),
                        labelText:
                            languageBloc.isLatvian ? 'Atbilde' : 'Answer',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: () {
                          checkAnswer(answerController.text, snapshot.data);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            languageBloc.isLatvian
                                ? 'Iesniegt atbildi'
                                : 'Submit answer',
                            style: new TextStyle(
                              fontSize: 27.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
