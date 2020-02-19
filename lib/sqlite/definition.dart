class Definition {
  int wordID;
  String definition;
  String definitionSource;
  String definitionSourceLink;
  String example;
  String exampleSource;

  Definition(this.wordID, this.definition, this.definitionSource, this.definitionSourceLink, this.example, this.exampleSource);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'wordID': wordID,
      'definition': definition,
      'definitionSource': definitionSource,
      'definitionSourceLink': definitionSourceLink,
      'example': example,
      'exampleSource': exampleSource,
    };
    return map;
  }

  Definition.fromMap(Map<String, dynamic> map) {
    wordID = map ['wordID'];
    definition = map ['definition'];
    definitionSource = map ['definitionSource'];
    definitionSourceLink = map ['definitionSourceLink'];
    example = map ['example'];
    exampleSource = map ['exampleSource'];
  }

}