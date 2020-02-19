import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:med/blocs/language_bloc.dart';
import 'package:med/drawer.dart';
import 'package:med/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class GrammarPage extends StatelessWidget {
  List patalizationFlex = [1, 2, 2];
  List patalization = [
    'Rule',
    'Singular nominative',
    'Plural genitive',
    'b, m, p, v -> +j',
    'urbis, zeme, upe, rīve',
    'urbju, zemju, upju, rīvju',
    'c -> č',
    'vecis, sūce',
    'veču, sūču',
    'd -> ž',
    'briedis, sirds (6th decl.)',
    'briežu, siržu',
    'l -> ļ',
    'valis, pīle',
    'vaļu, pīļu',
    'n -> ņ',
    'ronis, zirnis',
    'roņu, zirņu',
    's -> š',
    'lasis, puse',
    'lašu, pušu',
    't -> š',
    'latvietis, bite, krūts (6th decl.)',
    'latviešu, bišu, krūšu',
    'z -> ž',
    'vēzis, bize',
    'vēžu, bižu',
    'ln -> ļņ',
    'alnis, vilnis',
    'aļņu, viļņu',
    'll -> ļļ',
    'balle, lelle',
    'baļļu, leļļu',
    'sl -> šļ',
    'kāpslis',
    'kāpšļu',
    'sn -> šņ',
    'atkusnis, loksne',
    'atkušņu, lokšņu',
    'zl -> žļ',
    'zizlis',
    'zižļu',
    'zn -> žņ',
    'viznis, zvaigzne',
    'vižņu, zvaigžņu',
    'nn -> ņņ',
    'pinne',
    'piņņu',
    'kst -> kš',
    'pāksts (6th decl.)',
    'pākšu',
  ];
  List TwoEqualColomnFlex = [1,1];
  List FourEqualColomnFlex = [1,1,1,1];
  List OneTwoTwoColomnFlex = [1,2,2];
  List OneTwoTwoTwoColomnFlex = [1,2,2,2];
  List example = ["Latvian","English","","","",""];
  List NominativeExamples1 = ["Latvian","English","Mēs dzīvojam Rīgā.","We live in Riga.","Viņš ir students.","He is a student."];
  List NominativeExamples2 = ["Latvian","English","Viņam ir draudzene.","He has a girlfriend.","Pacientei nesāp kāja.","Patient’s leg doesn’t hurt."];
  List declension6Example = ["Singular nominative","Singular accusative","viens liels kauls","vienu lielu kaulu","viens liels brālis","vienu lielu brāli","viena liela māja","vienu lielu māju","viena liela universitāte","vienu lielu universitāti"];
  List GenitiveExamples1 = ["Latvian","English","Pacients iet pie ārsta.","The patient goes to a doctor.","Operācija bija pirms gada.","The operation was a year ago."];
  List GenitiveExamples2 = ["Latvian","English","Mēs studējam Medicīnas fakultātē.","We study in Faculty of Medicine.","Man sāp gudrības zobs.","My wisdom tooth hurts."];
  List GenitiveExamples3 = ["Latvian","English","Tā ir profesora pildspalva.","That is the professor’s pen.","Man vajag pacienta datus.","I need the patient’s data."];
  List GenitiveExamples4 = ["Latvian","English","Man ir daudz pacientu.","I have many patients.","Viņai nav naudas.","She doesn’t have money."];
  List DativeExamples1 = ["Latvian","English","Kopmītne ir blakus universitātei.","The dormitory is next to the university.","Jūs brauksiet pāri tiltam.","You will go across the bridge."];
  List DativeExamples2 = ["Latvian","English","Es esmu no Talsiem.","I am from Talsi.","Mēs iesim pie ārstiem.","We will go to doctors."];
  List DativeExamples3 = ["Latvian","English","Viņam ir draudzene.","He has a girlfriend.","Pacientei sāp kāja.","Patient’s leg hurts."];
  List DativeExamples4 = ["Latvian","English","Viņai ir divdesmit divi gadi.","She is twenty two years old.","Manai māsai ir pieci gadi.","My sister is five years old."];
  List DativeExamples5 = ["Latvian","English","Viņš strādās līdz sešiem.","He will work until six.","Es biju mājās no astoņiem.","I was at home since eight."];
  List DativeExamples6 = ["Latvian","English","Jums vajag šuves.","You need stitches.","Pacientam vajadzēs anestēziju.","The patient will need anaesthesia."];
  List DativeExamples7 = ["Latvian","English","Es viņam palīdzēšu.","I will help him.","Jūs man jautājāt...","You asked me..."];
  List AccusativeExamples1 = ["Latvian","English","Es braukšu ar autobusu.","I will go by bus.","Jums vajadzēs zāles pret klepu.","You will need medicine against the cough."];
  List AccusativeExamples2 = ["Latvian","English","Es studēju medicīnu.","I study medicine.","Viņa tīra zobus regulāri.","She brushes teeth regularly."];
  List AccusativeExamples3 = ["Latvian","English","Kūka maksā deviņus eiro.","The cake costs nine euros.","Kafija maksā deviņdesmit piecus centus.","The coffee costs ninety five cents."];
  List AccusativeExamples4 = ["Latvian","English","Jums vajag šuves.","You need stitches.","Pacientam vajadzēs anestēziju.","The patient will need anaesthesia."];
  List AccusativeExamples5 = ["Latvian","English","Manu dēlu sauc Rihards.","My son’s name is Rihards.","Klīniku sauc “Apvārsnis”.","The clinic is called “Apvārsnis”."];
  List AccusativeExamples6 = ["Latvian","English","Lietojiet zāles divas reizes dienā!","Take the medicine two times in a day!","Es slimoju divus gadus.","I was ill for two years."];
  List LocativeExamples1 = ["Latvian","English","Es biju bibliotēkā.","I was at the library.","Ārsts strādā slimnīcā.","The doctor works in a hospital."];
  List LocativeExamples2 = ["Latvian","English","Es lidošu uz Vāciju decembrī.","I will fly to Germany in December.","Vakaros es jūtos noguris.","In the evenings I feel tired."];
  List LocativeExamples3 = ["Latvian","English","Autobuss atiet sešos un piecās minūtēs.","The bus departs at six and five minutes.","Lekcijas beidzas piecos.","Lectures end at five."];
  List LocativeExamples4 = ["Latvian","English","Brokastīs es ēdu sviestmaizes.","I eat sandwiches for breakfast.","Ko jūs ēdāt vakariņās?","What did you eat for dinner?"];
  List PersonalPronouns1 = ['', 'I', 'we', 'Nom.', 'es', 'mēs','Gen.','manis','mūsu','Dat.','man','mums','Acc.','mani','mūs','Loc.','manī','mūsos',];
  List PersonalPronouns2 = ['','you(sg./inform.)','you(pl./form.)','Nom.','tu','jūs','Gen.','tevis','jūsu','Dat.','tev','jums','Acc.','tevi','jūs','Loc.','tevī','jūsos',];
  List PersonalPronouns3Singular = ['','he','she','Nom.','viņš','viņa','Gen.','viņa','viņas','Dat.','viņam','viņai','Acc.','viņu','viņu','Loc.','viņā','viņā',];
  List PersonalPronouns3Plural = ['','they(m.)','they(f.)','Nom.','viņi','viņas','Gen.','viņu','viņu','Dat.','viņiem','viņām','Acc.','viņus','viņas','Loc.','viņos','viņās',];
  List PosessivePronouns = ["","sg.","pl.","My*","mans (m.), mana (f.) ","mani (m.), manas (f.)","Your* (sg./inform.)","tavs (m.), tava (f.)","tavi (m.), tavas (f.)","His","viņa","viņa","Her","viņas","viņas","Our","mūsu","mūsu","Your(pl./form.)","jūsu","jūsu","Their (m.)","viņu","viņu","Their (f.)","viņu","viņu"];
  List VerbsExamples1 = ["būt (to be)","Present","Past","Future","es","esmu (neesmu)","biju \n(nebiju)","būšu (nebūšu)","tu","esi \n (neesi)","biji \n(nebiji)","būsi \n(nebūsi)","viņš, viņa","ir \n(nav)","bija \n(nebija)","būs \n(nebūs)","mēs","esam \n(neesam)","bijām \n(nebijām)","būsim \n(nebūsim)","jūs","esat\n (neesat)","bijāt \n(nebijāt)","būsiet \n(nebūsiet)","viņi, viņas","ir \n(nav)","bija \n(nebija)","būs \n(nebūs)",];
  List VerbsExamples2 = ["ēst \ndzert ","Present","Past","Future","es","ēdu\ndzeru","ēdu\ndzēru","ēdīšu\ndzeršu","tu","ēd\ndzer","ēdi\ndzēri","ēdīsi\ndzersi","viņš, viņa","ēd\dzer","ēda\ndzēra","ēdīs\ndzers","mēs","ēdam\ndzeram","ēdām\ndzērām","ēdīsim\ndzersim","jūs","ēdat\ndzerat","ēdāt\ndzērāt","ēdīsiet\ndzersiet","viņi, viņas","ēd\ndzer","ēda\ndzēra","ēdīs\ndzers",];
  List VerbsExamples3 = ["iet \nbraukt \nnākt","Present","Past","Future","\nes","eju\nbraucu\nnāku","gāju\nbraucu\nnācu","iešu\nbraukšu\nnākšu","\ntu","ej\nbrauc\nnāc","gāji\nbrauci\nnāci","iesi\nbrauksi\nnāksi","\nviņš, viņa","iet\nbrauc\nnāk","gāja\nbrauca\nnāca","ies\nbrauks\nnāks","\nmēs","ejam\nbraucam\nnākam","gājām\nbraucām\nnācām","iesim\nbrauksim\nnāksim","\njūs","ejat\nbraucat\nnākat","gājāt\nbraucāt\nnācāt","iesiet\nbrauksiet\nnāksiet","\nviņi, viņas","iet\nbrauc\nnāk","gāja\nbrauca\nnāca","ies\nbrauks\nnāks",];
  List VerbsExamples4 = ["studēt \nstrādāt \ndzīvot ","Present","Past","Future","\nes","studēju\nstrādāju\ndzīvoju","studēju\nstrādāju\ndzīvoju","studēšu\nstrādāšu\ndzīvošu","\ntu","studē\nstrādā\ndzīvo","studēji\nstrādāji\ndzīvoji","studēsi\nstrādāsi\ndzīvosi","\nviņš, viņa","studē\nstrādā\ndzīvo","studēja\nstrādāja\ndzīvoja","studēs\nstrādās\ndzīvos","\nmēs","studējam\nstrādājam\ndzīvojam","studējām\nstrādājām\ndzīvojām","studēsim\nstrādāsim\ndzīvosim","\njūs","studējat\nstrādājat\ndzīvojat","studējāt\nstrādājāt\ndzīvojāt","studēsiet\nstrādāsiet\ndzīvosiet","\nviņi, viņas","studē\nstrādā\ndzīvo","studēja\nstrādāja\ndzīvoja","studēs\nstrādās\ndzīvos",];
  List VerbsExamples5 = ["lasīt \n(to read","Present","Past","Future","es","lasu","lasīju","lasīšu","tu","lasi","lasīji","lasīsi","viņš, viņa","lasa","lasīja","lasīs","mēs","lasām","lasījām","lasīsim","jūs","lasāt","lasījāt","lasīsiet","viņi, viņas","lasa","lasīja","lasīs",];
  List VerbsExamples6 = ["turpināt\n (to continue)","Present","Past","Future","es","turpinu","turpināju","turpināšu","tu","turpini","turpināji","turpināsi","viņš, viņa","turpina","turpināja","turpinās","mēs","turpinām","turpinājām","turpināsim","jūs","turpināt","turpinājāt","turpināsiet","viņi, viņas","turpina","turpināja","turpinās",];
  List VerbsExamples7 = ["gribēt\n (to want)","Present","Past","Future","es","gribu","gribēju","gribēšu","tu","gribi","gribēji","gribēsi","viņš, viņa","grib","gribēja","gribēs","mēs","gribam","gribējām","gribēsim","jūs","gribat","gribējāt","gribēsiet","viņi, viņas","grib","gribēja","gribēs",];
  List ImperativeExample = ['Tu ej. \n (You are going.)','Ej! \n(Go!)','Tu raksti. \n(You are writing.)','Raksti! \n(Write!)','Tu mācies. \n(You are learning.)','Mācies! \n (Learn!)',];
  //\n
  @override
  Widget NounsTable(
      sgNom, sgGen, sgDat, sgAcc, sgLoc, plNom, plGen, plDat, plAcc, plLoc) {
    return Table(
        border: TableBorder.all(width: 2, color: Colors.black),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
        },
        children: [
          TableRow(children: [
            Text(
              "",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              "sg.",
              style: TextStyle(
                  fontSize: 20, height: 1.3, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "pl.",
              style: TextStyle(
                  fontSize: 20, height: 1.3, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ]),
          TableRow(children: [
            Text(
              "Nom.",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              sgNom,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              plNom,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ]),
          TableRow(children: [
            Text(
              "Gen.",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              sgGen,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              plGen,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ]),
          TableRow(children: [
            Text(
              "Dat.",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              sgDat,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              plDat,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ]),
          TableRow(children: [
            Text(
              "Acc.",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              sgAcc,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              plAcc,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ]),
          TableRow(children: [
            Text(
              "Loc.",
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              sgLoc,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
            Text(
              plLoc,
              style: TextStyle(fontSize: 20, height: 1.3),
              textAlign: TextAlign.center,
            ),
          ]),
        ]);
  }

  Widget NounsExample(Widget tableWidget) {
    return Column(
      children: <Widget>[
        ExpandablePanel(
          collapsed: Row(
            children: <Widget>[
              Text('Open Example',
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_downward),
            ],
          ),
          expanded: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Close Example ',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_upward),
                ],
              ),
              tableWidget,
            ],
          ),
          tapHeaderToExpand: true,
          hasIcon: false,
          tapBodyToCollapse: true,
        ),
      ],
    );
  }
  Widget printHTML(String HTML, double fontSize){
    return Html(
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        return baseStyle
            .merge(TextStyle(fontSize: fontSize, height: 1));
      },
      data:
      ""+HTML,
    );
  }
  Widget tableBuilder(List flexList, List dataList, int rowLength, bool haveHeader) {
    List<TableRow> tableRows = [];
    List<Widget> cell = [];
    var i, j, count = 0;
    for (i = 0; i < dataList.length / rowLength; i++) {
      print(i.toString());
      tableRows.add(TableRow(children: [
        for (j = 0; j < rowLength; j++)
          Text(
            dataList[i * rowLength + j],
            style: TextStyle(
                fontSize: i + rowLength <= rowLength && haveHeader
                    ? 20 : 18,
                height: 1.3,
                fontWeight: i + rowLength <= rowLength && haveHeader
                    ? FontWeight.bold
                    : FontWeight.normal),
            textAlign: TextAlign.center,
          ),
      ]));
      count = rowLength;
    }
    return Table(
        border: TableBorder.all(width: 2, color: Colors.black),
        columnWidths: {
          0: FlexColumnWidth(flexList[0].toDouble()),
          1: FlexColumnWidth(flexList[1].toDouble()),

          2: FlexColumnWidth(rowLength > 2 ? flexList[2].toDouble() : 0),
          3: FlexColumnWidth(rowLength > 3 ? flexList[3].toDouble() : 0),
          4: FlexColumnWidth(rowLength > 4 ? flexList[4].toDouble() : 0),
        },
        children: tableRows

        );
  }
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
  Widget tableContainer(String text, double fontSize, bool isBold, Border border){
    return Container(
      decoration: BoxDecoration( border: border),
      //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    final LanguageBloc languageBloc = Provider.of<LanguageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: languageBloc.isLatvian
            ? new Text('Gramatikas pārskats')
            : new Text('Overview of Latvian grammar'),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'NOUNS',
                    style: TextStyle(
                        fontSize: 37,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'MASCULINE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    '1st declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-s, -š', '-a', '-am', '-u', '-ā', '-i', '-u',
                      '-iem', '-us', '-os'),
                  SizedBox(
                    height: 10,
                  ),
                  printHTML( "<p><b>Also used for: </b>masculine adjectives, numerals, and pronouns <i>kāds, kurš, mans, tavs</i>.</p>", 20),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable(
                      'kauls, vējš',
                      'kaula, vēja',
                      'kaulam, vējam',
                      'kaulu, vēju',
                      'kaulā, vējā',
                      'kauli, vēji',
                      'kaulu, vēju',
                      'kauliem, vējiem',
                      'kaulus, vējus',
                      'kaulos, vējos')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  //2ND DECLENSION
                  Text(
                    '2nd declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-is  |  -s**', '-a*	 |  -s**', '-im', '-i', '-ī',
                      '-i*', '-u*', '-iem*', '-us*', '-os*'),
                  SizedBox(
                    height: 10,
                  ),
                  printHTML("<b>*Palatalization (see below)</b><br> <b>**Only the following words:</b> <i>akmens, asmens, mēness, rudens, sāls, ūdens, zibens</i>.", 20),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable(
                      'brālis |	ūdens',
                      'brāļa |	ūdens',
                      'brālim, ūdenim',
                      'brāli, ūdeni',
                      'brālī, ūdenī',
                      'brāļi, ūdeņi',
                      'brāļu, ūdeņu',
                      'brāļiem, ūdeņiem',
                      'brāļus, ūdeņus',
                      'brāļos, ūdeņos')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    '3rd declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-us', 'us', '-um', '-u', '-ū', '-i', '-u', '-iem',
                      '-us', '-os'),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable(
                      'klepus',
                      'klepus',
                      'klepum',
                      'klepu',
                      'klepū',
                      'klepi',
                      'klepu',
                      'klepiem',
                      'klepus',
                      'klepos')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'FEMINE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    '4th declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-a', '-as', '-ai', '-u', '-ā', '-as', '-u', '-ām',
                      '-as', '-ās'),
                  SizedBox(
                    height: 10,
                  ),
                  printHTML( "<p><b>Also used for: </b>feminine adjectives, numerals, and pronouns  <i>kāda, kura, mana, tava</i>.</p>", 20),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable('roka', 'rokas', 'rokai', 'roku',
                      'rokā', 'rokas', 'roku', 'rokām', 'rokas', 'rokās')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    '5th declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-e', '-es', '-ei', '-i', '-ē', '-es', '-u*',
                      '-ēm', '-es', '-ēs'),
                  SizedBox(
                    height: 10,
                  ),
                  printHTML("<p><b>*Palatalization (see below)</b></p>", 20),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable('mēle', 'mēles', 'mēlei', 'mēli',
                      'mēlē', 'mēles', 'mēļu', 'mēlēm', 'mēles', 'mēlēs')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    '6th declension',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  NounsTable('-s', '-s', '-ij', '-i', '-ī', '-is', '-u*', '-ēm',
                      '-es', '-ēs'),
                  SizedBox(
                    height: 10,
                  ),
                  printHTML("<p><b>*Palatalization (see below)</b><br><b>Only selected words:</b> <i>acs, asins, auss, krūts, nakts, sirds, uguns etc.</i></p>", 20),
                  SizedBox(
                    height: 10,
                  ),
                  NounsExample(NounsTable(
                      'asins',
                      'asins',
                      'asinij',
                      'asini',
                      'asinī',
                      'asinis',
                      'asiņu',
                      'asinīm',
                      'asinis',
                      'asinīs')),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  printHTML("<p>If a numeral, an adjective a declinable pronoun or a declinable question word is used with a noun, they must be the same <b>gender, number,</b> and <b>case</b> – but the endings can be different from the noun’s ending. </p>", 20),
                 NounsExample(tableBuilder(TwoEqualColomnFlex, declension6Example, 2, true),),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Palatalization',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  printHTML( "<p>Palatalization is a change in consonants right before the ending of a noun in <u>certain positions:</u></p>"
                      "<ul>"
                      "<li>2nd declension nouns ending with <b>-is</b> – in singular genitive;</li>"
                      "<li>All 2nd declension nouns in all plural forms;</li>"
                      "<li>5th and 6th declension nouns – in plural genitive.</li>"
                      "</ul>", 20),
                  SizedBox(
                    height: 10,
                  ),
                  tableBuilder(patalizationFlex, patalization, 3, true),
                  printHTML("<p><b>Some exceptions:</b> words where consonants are <b>not</b> palatalized: 2nd declension nouns <i>tētis, Guntis, Gatis;</i> 5th declension noun <i>mute</i>; 6th declension nouns <i>acs, auss, brokastis, Cēsis, uzacs, valsts</i>.</p>", 20),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'USE OF CASES',
                    style: TextStyle(
                        fontSize: 37,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'NOMINATIVE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  SizedBox(height: 10,),
                  printHTML("<p><b>Subject</b> of the sentence.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, NominativeExamples1, 2, true),),
                  SizedBox(height: 10,),
                  printHTML("<p>The object / body part that someone has, likes or has pain in <b>(ir; garšo; patīk; sāp)</b>.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, NominativeExamples2, 2, true),),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'GENITIVE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  printHTML("<p>With prepositions* <b>bez, kopš, no, pēc, pie, pirms, uz**</b> – only in singular.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, GenitiveExamples1, 2, true),),
                  printHTML("<p><b>Noun + noun</b> phrases (sometimes translated into English with of): <b>every word except the last one</b> is in genitive. </p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, GenitiveExamples2, 2, true),),
                  printHTML("<p>Phrases saying <b>whose</b> something is.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, GenitiveExamples3, 2, true),),
                  printHTML("<p>With certain words:  <b>daudz, maz, cik, nav***.</b></p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, GenitiveExamples4, 2, true),),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'DATIVE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  printHTML("<p>With prepositions* <b>blakus, cauri, garām, līdz, pāri.</b></p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples1, 2, true),),
                  printHTML("<p>With any <b>preposition*</b> in <b>plural.</b></p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples2, 2, true),),
                  printHTML("<p>When talking about <b>having, liking or hurting,</b> the person who has, likes, or experiences pain.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples3, 2, true),),
                  printHTML("<p>Saying someone’s <b>age</b>: a person “has years”.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples4, 2, true),),
                  printHTML("<p>Saying <b>from</b> what time <b>until</b> what time something happens.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples5, 2, true),),
                  printHTML("<p>With <b>vajag</b> – to say <b>who needs</b> something.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples6, 2, true),),
                  printHTML("<p><b>Indirect object</b> in the sentence, the <b>recipient</b>, the one <b>for whom</b> or <b>to whom</b> something is done.</p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, DativeExamples7, 2, true),),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'ACCUSATIVE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  printHTML("<p><span>With prepositions* <strong>ar, pa, par, pret, starp, uz</strong>**** – <u>only</u> in singular.</span></p>", 20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples1, 2, true),),
                  printHTML("<p><strong>Direct object</strong> (answers to <em>what?</em> but is not the subject). <u>Except:</u> having, liking, hurting (see nominative’s rules).</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples2, 2, true),),
                  printHTML("<p>Saying how much something <strong>costs</strong>.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples3, 2, true),),
                  printHTML("<p>With <strong>vajag</strong> – to say <strong>what is needed</strong>*****.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples4, 2, true),),
                  printHTML("<p>With&nbsp;<strong>sauc</strong> – to say what someone’s name is / what something is called.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples5, 2, true),),
                  printHTML("<p>Saying <strong>how long / how often</strong> something happens.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, AccusativeExamples6, 2, true),),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'LOCATIVE',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  printHTML("<p>Saying <strong>where&nbsp;</strong>something is.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, LocativeExamples1, 2, true),),
                  printHTML("<p>Saying <strong>when</strong> something happens.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, LocativeExamples2, 2, true),),
                  printHTML("<p>Saying <strong>at what time</strong> something happens.</p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, LocativeExamples3, 2, true),),
                  printHTML("<p>Saying what someone eats <strong>for breakfast / lunch / dinner.</strong></p>",20),
                  NounsExample(tableBuilder(  TwoEqualColomnFlex, LocativeExamples4, 2, true),),
                  SizedBox(height: 10,),
                  Text('* If the noun or pronoun is used with a preposition, no other rules can be applied: prepositions overrule everything.',style: TextStyle(fontSize: 20),),
                  printHTML("<p>**Only when it means <em>on</em>, <em>onto</em>.</p>",20),
                  printHTML("<p>***Only when speaking about <u>not having</u>.</p>",20),
                  printHTML("<p>****Only when it means <em>to</em>.</p>",20),
                  printHTML('<p>*****If <em>vajag&nbsp;</em>is used with a verb, that verb is used in infinitive:  "Man vajag <strong>samaksāt</strong>. (I need <strong>to pay</strong>.)"</p>',20),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'PRONOUNS',
                    style: TextStyle(
                        fontSize: 37,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'PERSONAL PRONOUNS',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  SizedBox(height: 10,),
                  printHTML("<p><strong>1st person</strong></p>",20),
                  tableBuilder(OneTwoTwoColomnFlex, PersonalPronouns1, 3, true),
                  printHTML("<p><strong>2nd person</strong></p>",20),
                  tableBuilder(OneTwoTwoColomnFlex, PersonalPronouns2, 3, true),
                  printHTML("<p><strong>3rd person(singular)</strong></p>",20),
                  tableBuilder(OneTwoTwoColomnFlex, PersonalPronouns3Singular, 3, true),
                  printHTML("<p><strong>3rd person(plural)</strong></p>",20),
                  tableBuilder(OneTwoTwoColomnFlex, PersonalPronouns3Plural, 3, true),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  Text(
                    'POSESSIVE  PRONOUNS',
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  tableBuilder(OneTwoTwoColomnFlex, PosessivePronouns, 3, true),
                  Text(
                    '* Forms in cases other than nominative are made according to the 1st declension’s (masculine) or 4th declension’s (feminine) paradigm.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'VERBS',
                    style: TextStyle(
                        fontSize: 37,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Verbs: having, liking, hurting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 16,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration( border: Border.all()),
                                  //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
                                  child: Center(
                                    child: Text(
                                      '',
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                  ),
                                ),
                                tableContainer("man", 18, false, Border.all()),
                                tableContainer("tev", 18, false, Border.all()),
                                tableContainer("viņam", 18, false, Border.all()),
                                tableContainer("viņai", 18, false, Border.all()),
                                tableContainer("mums", 18, false, Border.all()),
                                tableContainer("jums", 18, false, Border.all()),
                                tableContainer("viņiem", 18, false, Border.all()),
                                tableContainer("viņām", 18, false, Border.all()),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 22,
                            child: Column(
                              children: <Widget>[
                                Container(

                                  decoration: BoxDecoration( border: Border.all()),
                                  //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
                                  child: Center(
                                    child: Text(
                                      'Present',
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                  ),
                                ),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("ir", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nav)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("patīk", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nepatīk)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("garšo", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(negaršo)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("sāp", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nesāp)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1), bottom: BorderSide(color: Colors.black ,width: 1))),

                              ],
                            ),
                          ),
                          Expanded(
                            flex: 21,
                            child: Column(
                              children: <Widget>[
                                Container(

                                  decoration: BoxDecoration( border: Border.all()),
                                  //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
                                  child: Center(
                                    child: Text(
                                      'Past',
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                  ),
                                ),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("bija ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nebija)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("patika ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nepatika)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("garšoja ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(negaršoja)", 14, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("sāpēja ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nesāpēja)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1), bottom: BorderSide(color: Colors.black ,width: 1))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 22,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration( border: Border.all()),
                                  //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
                                  child: Center(
                                    child: Text(
                                      'Future',
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                  ),
                                ),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("būs  ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nebūs)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("patiks  ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nepatiks)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("garšos  ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(negaršos)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 5, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("sāpēs  ", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("(nesāpēs)", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 9, true, Border(right: BorderSide(color: Colors.black ,width: 1), bottom: BorderSide(color: Colors.black ,width: 1))),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 19,
                            child: Column(
                              children: <Widget>[
                                Container(

                                  decoration: BoxDecoration( border: Border.all()),
                                  //padding: const EdgeInsets.only(),//             <--- BoxDecoration here
                                  child: Center(
                                    child: Text(
                                      '',
                                      style: TextStyle(fontSize: 20,),
                                    ),
                                  ),
                                ),
                                tableContainer("", 70, true, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("+Nom.*", 15, false, Border(right: BorderSide(color: Colors.black ,width: 1))),
                                tableContainer("", 69, true, Border(right: BorderSide(color: Colors.black ,width: 1), bottom: BorderSide(color: Colors.black ,width: 1))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      printHTML("<p>* Verb <em>(ne)patīk, (ne)patika, (ne)patiks</em> can also be used with a verb in infinitive:</p>", 20),
                      printHTML("<p>Man patīk <strong>Rīga</strong>. (I like <strong>Riga</strong>.)</p>", 20),
                      printHTML("<p>Man patīk <strong>ceļot</strong>. (I like <strong>to travel)</strong></p>", 20),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      Text('Verbs: 1st conjugation / irregular', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      tableBuilder(OneTwoTwoTwoColomnFlex, VerbsExamples1, 4, true),
                      SizedBox(height: 30,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples2, 4, true),
                      SizedBox(height: 30,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples3, 4, true),
                      SizedBox(height: 30,),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      printHTML("<p><strong>Verbs: 2nd conjugation, endings <em>-ēt, -āt, -ot</em></strong></p>", 20),
                      SizedBox(height: 10,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples4, 4, true),
                      printHTML("<p><strong>All&nbsp;</strong>verbs that end with <strong>-ot</strong> in infinitive are conjugated like the 2nd conjugation.&nbsp;</p>", 20),
                      printHTML("<p><strong>All</strong> verbs that end with <strong>-āt (but not -ināt!)</strong> in infinitive are conjugated like the 2nd conjugation.&nbsp;</p>", 20),
                      printHTML("<p><strong>A part of</strong> verbs that end with <strong>-ēt</strong> in infinitive are conjugated like the 2nd conjugation.&nbsp;</p>", 20),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      printHTML("<p><strong>Verbs: 3rd conjugation, ending <em>-īt</em></strong></p>", 20),
                      SizedBox(height: 10,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples5, 4, true),
                      printHTML("<p><strong>All&nbsp;</strong>verbs that end with <strong>-īt</strong> in infinitive are conjugated like the 3rd conjugation.</p>", 20),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      printHTML("<p><strong>Verbs: 3rd conjugation, ending <em>-ināt</em></strong></p>", 20),
                      SizedBox(height: 10,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples6, 4, true),
                      printHTML("<p><strong>All</strong> verbs that end with <strong>-ināt</strong> in infinitive are conjugated like the 3rd conjugation. </p>", 20),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      printHTML("<p><strong>Verbs: 3rd conjugation, ending <em>-ēt</em></strong></p>", 20),
                      SizedBox(height: 10,),
                      tableBuilder(FourEqualColomnFlex, VerbsExamples7, 4, true),
                      printHTML("<p><strong>A part of</strong> verbs that end with <strong>-ēt</strong> in infinitive are conjugated like the 3rd conjugation. </p>", 20),
                      SizedBox(height: 15,),
                      printHTML("<p>*To say that someone wants, can or is allowed to do something, the verbs <strong><em>gribēt, varēt, drīkstēt&nbsp;</em>are conjugated</strong> and the <strong>following verb</strong> is used in <strong>infinitive</strong>:</p>", 20),
                      printHTML("<p>Es gribu <strong>gulēt</strong>. <em>(I want <strong>to sleep</strong>.)</em></p> <p>Vai&nbsp;jūs varat man <strong>palīdzēt</strong>? <em>(Can you <strong>help</strong> me?)</em></p> <p>Viņš nedrīkst <strong>iet&nbsp;</strong>mājās. <em>(He is not allowed <strong>to go</strong> home.)</em></p>", 20),
                      SizedBox(height: 10,),
                      Divider(
                        height: 20,
                        color: Colors.blueGrey,
                        thickness: 2,
                      ),
                      Text('Imperative', style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
                      printHTML("<p><strong>Imperative</strong> is a form of verbs that is used to give orders, commands, requests, recommendations.</p>", 20),
                      SizedBox(height: 10,),
                      printHTML("<p>Ejiet mājās! <em>(Go home!)</em></p>", 20),
                      printHTML("<p>Atveriet muti! <em>(Open your mouth!)</em></p>", 20),
                      printHTML("<p>Ēdiet vairāk dārzeņu! <em>(Eat more vegetables!)</em></p>", 20),
                      SizedBox(height: 10,),
                      printHTML("<p>The <strong>informal / singular imperative</strong> form is the same as informal / singular <strong>present</strong> form:</p>", 20),
                      tableBuilder(TwoEqualColomnFlex, ImperativeExample, 2, false),
                    ],
                  )
//                  new Table(
//                      border: new TableBorder(
//                          //horizontalOutside: new BorderSide(color: Colors.black, width: 2),
//                          right: new BorderSide(color: Colors.black, width: 2),
//                          left: new BorderSide(color: Colors.black, width: 2),
//
//                      ),
//                      columnWidths: new Map.from({
//                        0: new FixedColumnWidth(50.0),
//                        1: new FixedColumnWidth(180.0),
//                        2: new FixedColumnWidth(100.0)
//                      }),
//                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                      children: <TableRow>[
//                        new TableRow(
//                            children: <Widget>[
//                              new Container(
//                                  padding: new EdgeInsets.all(10.0),
//                                  child: new Icon(Icons.account_balance)
//                              ),
//                              new Text("Row 1"),
//                              new Text("\$300,000")
//                            ]
//                        ),
//                        new TableRow(
//                            children: <Widget>[
//                              new Container(
//                                  padding: new EdgeInsets.all(10.0),
//                                  child: new Icon(Icons.account_balance)
//                              ),
//                              new Text("Row 2"),
//                              new Text("\$30,000,000")
//                            ]
//                        ),
//                        new TableRow(
//                            children: <Widget>[
//                              new Container(
//                                  padding: new EdgeInsets.all(10.0),
//                                  child: new Icon(Icons.account_balance)
//                              ),
//                              new Text("Row 3"),
//                              new Text("\$300,000")
//                            ]
//                        ),
//                      ]
//                  )
                 ],
              ),
            ),

          ],
        ),
      )),
    );
  }
}
