class Source {
  int sourceID;
  String sourceCode;
  String source;

  Source(this.sourceID, this.sourceCode, this.source);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'sourceID': sourceID,
      'sourceCode': sourceCode,
      'source': source,
    };
    return map;
  }
  Source.fromMap(Map<String, dynamic> map) {
    sourceID = map ['sourceID'];
    sourceCode = map ['sourceCode'];
    source = map ['source'];
  }

}


