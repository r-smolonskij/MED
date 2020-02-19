class Relationship {
  int relationshipID;
  int wordID;
  int fieldID;

  Relationship(this.relationshipID, this.wordID, this.fieldID);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'relationshipID': relationshipID,
      'wordID': wordID,
      'fieldID': fieldID,
    };
    return map;
  }

  Relationship.fromMap(Map<String, dynamic> map) {
    relationshipID = map ['relationshipID'];
    wordID = map ['wordID'];
    fieldID = map ['fieldID'];
  }

}