class Field {
  int fieldID;
  String fieldLV;
  String fieldENG;

  Field(this.fieldID, this.fieldLV, this.fieldENG);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'fieldID': fieldID,
      'fieldLV': fieldLV,
      'titleENG': fieldENG,
    };
    return map;
  }
  String getTitleLV(){
    return fieldLV;
  }

  Field.fromMap(Map<String, dynamic> map) {
    fieldID = map ['fieldID'];
    fieldLV = map ['fieldLV'];
    fieldENG = map ['fieldENG'];
  }

}
//class Field {
//  int fieldID;
//  String field;
//
//
//  Field(this.fieldID, this.field);
//
//  Map<String, dynamic> toMap(){
//    var map = <String, dynamic>{
//      'field': field,
//      'fieldID': fieldID,
//    };
//    return map;
//  }
//
//  Field.fromMap(Map<String, dynamic> map) {
//    field = map ['field'];
//    fieldID = map ['fieldID'];
//  }
//
//}

