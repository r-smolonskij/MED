class Word {
  int wordID;
  String wordLV;
  String wordENG;
  String wordType;


  Word(
      this.wordID,
      this.wordLV,
      this.wordENG,
      this.wordType,

      );
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'wordID': wordID,
      'wordLV': wordLV,
      'wordType': wordType,
    };
    return map;
  }

  Word.fromMap(Map<String, dynamic> map) {
    wordID = map['wordID'];
    wordLV = map['wordLV'];
    wordENG = map['wordENG'];
    wordType = map['wordType'];
  }
}
//class Word {
//  int wordID;
//  String wordLV;
//  String wordENG;
//  String type;
//
//  Word(this.wordID, this.wordLV, this.wordENG, this.type);
//
//  Map<String, dynamic> toMap(){
//    var map = <String, dynamic>{
//      'wordID': wordID,
//      'wordLV': wordLV,
//      'wordENG': wordENG,
//      'type': type,
//    };
//    return map;
//  }
//
//  Word.fromMap(Map<String, dynamic> map) {
//    wordID = map ['wordID'];
//    wordLV = map ['wordLV'];
//    wordENG = map ['wordENG'];
//    type = map ['type'];
//  }
//
//}
