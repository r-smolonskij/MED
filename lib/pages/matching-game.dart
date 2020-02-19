import 'package:flutter/material.dart';
import 'package:med/sqlite/database_helper.dart';
import 'package:med/sqlite/db_helper.dart';
import 'package:med/sqlite/field.dart';
import 'package:med/sqlite/word.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';

class MatchingGame extends StatefulWidget {
  final int fieldID;
  MatchingGame(this.fieldID);
  @override
  _MatchingGameState createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  int wordsCount;
  var rng = new Random();
  Word correctAnswer;
  //DatabaseHelper dbHelper = DatabaseHelper();
  DBHelper dbHelper = DBHelper();
  List<Word> answerVariation = List();
  String wordType;

  Future<List<Word>> _getRandomWords() async {
    answerVariation.clear();
    Field field = await dbHelper.getFieldByID(widget.fieldID);
    List<Word> words = await dbHelper.getWordsByFieldID(field.fieldID);
    int wordsCount = words.length;
    List<int> numbers = List();
    correctAnswer = words[rng.nextInt(wordsCount)];
    var count = await dbHelper.getWordsCountByFieldIDandType(field.fieldID, correctAnswer.wordType);
    answerVariation.add(correctAnswer);
    wordType = correctAnswer.wordType;
    for (var i = 1; i < 4;) {
      var randomNumber = rng.nextInt(wordsCount);
      if (!numbers.contains(randomNumber) && words[randomNumber].wordType == correctAnswer.wordType) {
        numbers.add(randomNumber);
        answerVariation
            .add(await dbHelper.getWordByID(words[randomNumber].wordID));
        i++;
      }
    }
    answerVariation.shuffle();
    return answerVariation;
  }
  Widget instructionText(Word word, String type) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Column(
      children: <Widget>[
        type =='V' ? Text(
          languageBloc.isLatvian ?
          'Izvēlieties šim vārdam/frāzei tulkojumu angļu valodā: ' :
          'Choose Latvian translation to this word/phrase: ',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ) : SizedBox(height: 0,),
        type =='J' ? Text(
          languageBloc.isLatvian ?
          'Izvēlieties šim jautājumam tulkojumu angļu valodā: ' :
          'Choose Latvian translation to this question: ',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ) : SizedBox(height: 0,),
        type =='N' ? Text(
          languageBloc.isLatvian ?
          'Izvēlieties šim norādījumam tulkojumu angļu valodā: ' :
          'Choose Latvian translation to this instruction: ',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ) : SizedBox(height: 0,),
        type=='' ? Text(
          languageBloc.isLatvian ?
          'Izvēlieties šim tulkojumu angļu valodā: ' :
          'Choose Latvian translation to this: ',
          style: TextStyle(
            fontSize: 28.0,
          ),
        ) : SizedBox(height: 0,),
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

  Word getCorrectAnswer(List<Word> words) {
    var randomNumber = rng.nextInt(4);
    return words[randomNumber];
  }

  Future<bool> checkAnswer(Word answer, Word word) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    if (answer == word) {
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
            onPressed: () {
              setState(() {
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
            ? 'Pareizā atbilde: ' + answer.wordENG
            : 'Correct answer: ' + answer.wordLV,
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
                Navigator.pop(context);
              });
            },
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(languageBloc.isLatvian ? '"Saliec kopā"' : 'Matching Game'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getRandomWords(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else {
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:
                          instructionText(correctAnswer, wordType),
                    ),
                    new Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: RaisedButton(
                              color: Colors.deepPurple,
                              textColor: Colors.white,
                              onPressed: () {
                                checkAnswer(correctAnswer,
                                    snapshot.data[index]);
                              },
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      languageBloc.isLatvian
                                          ? snapshot.data[index].wordENG
                                          : snapshot.data[index].wordLV,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
