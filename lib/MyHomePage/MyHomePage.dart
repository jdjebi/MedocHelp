import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:text_to_speech/text_to_speech.dart';
import 'package:translator/translator.dart';
import 'package:html/parser.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import '../ArView/ArView.dart';


const d_green = Color(0xFF54D3C2);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;

  bool isInitilized = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitilized = true;
    });
    super.initState();
  }


  _text_to_speech(){

    TextToSpeech tts = TextToSpeech();

    String language = 'fr';
    tts.setLanguage(language);

    double volume = 1.0;
    tts.setVolume(volume);
    String text = "pingbin ni baka n’ga be nian gnan man afouè blou ni nou bé kloua fa man aré n’ga. Bé fè min pè koun ba.sè vié liè ô kô bo yôya a kloi fa. A réma n’ga beho nou bé non bé ni n’zoué , i koussou a kloi min koun n'glin mi koun midi sou  koun n'do soua";
    tts.speak(text);

  }


  _startScan(int option) async {
    List<OcrText> list = [];

    var data = {};

    try {
      list = await FlutterMobileVision.read(
        waitTap: true,
        fps: 1.0,
        multiple: false,
        showText: true,
      );

      Future<String> goodValue() async {
        for (OcrText text in list) {
          String ab = text.value;
          String scrapValue = ab.toUpperCase();
          var tab = scrapValue.split(' ');
          for (String element in tab) {
            String url = 'https://www.doctissimo.fr/medicament-$element.htm';
            final response = await http.get(Uri.parse(url));
            final body = response.body;
            final html = parse(body);
            final indication =
            html.querySelector("#collapseIndication")?.text.trim();
            if (indication != null) {
              return element;
            }
          }
        }

        return "null";
      }

      goodValue().then((value) async {
        if (value == "null") {
          _startScan(2);
        } else {
          String url = 'https://www.doctissimo.fr/medicament-$value.htm';
          final translator = GoogleTranslator();
          final response = await http.get(Uri.parse(url));
          final body = response.body;
          final html = parse(body);

          final indication =
          html.querySelector("#collapseIndication")?.text.trim();
          final posologie = html.querySelector("#collapseDosage")?.text.trim();
          final effet = html.querySelector("#collapseEffect")?.text.trim();
          final cIndication = html.querySelector("#collapseCI")?.text.trim();
          final precaution =
          html.querySelector("#collapsePrecaution")?.text.trim();
          final interaction =
          html.querySelector("#collapseInteraction")?.text.trim();
          final surdosage = html.querySelector("#collapseSurdosage")?.text.trim();
          final grossesse = html.querySelector("#collapseGrossesse")?.text.trim();

          var lang = 'fr';

          if (option==2)
          {
            lang = 'en';
          }

          if(option==3)
          {
            lang = 'es';
          }

          if(option==4)
          {
            lang = 'fr';
          }


          final indication_trans =
          await translator.translate(indication!, from: 'fr', to: lang);
          final posologie_trans =
          await translator.translate(posologie!, from: 'fr', to: lang);
          final effet_trans =
          await translator.translate(effet!, from: 'fr', to: lang);
          final cIndication_trans =
          await translator.translate(cIndication!, from: 'fr', to: lang);
          final precaution_trans =
          await translator.translate(precaution!, from: 'fr', to: lang);
          final interaction_trans =
          await translator.translate(interaction!, from: 'fr', to: lang);
          final surdosage_trans =
          await translator.translate(surdosage!, from: 'fr', to: lang);
          final grossesse_trans =
          await translator.translate(grossesse!, from: 'fr', to: lang);

          var baoule = "pingbin ni baka n’ga be nian gnan man afouè blou ni nou bé kloua fa man aré n’ga. Bé fè min pè koun ba.sè vié liè ô kô bo yôya a kloi fa. A réma n’ga beho nou bé non bé ni n’zoué , i koussou a kloi min koun n'glin mi koun midi sou  koun n'do soua";



          if (option==4){

            data = {'Indication': baoule,
              'posologie': '',
              'effet': '',
              'Contre_indication':'',
              'precaution':'',
              'interaction':'',
              'surdosage':'',
              'grossesse':'',
              'langue': lang
            };

            print(data['Indication']);
            print(option);
            print("ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg666666666666666666");

          }else{
            data = {'Indication': indication_trans,
              'posologie': posologie_trans,
              'effet': effet_trans,
              'Contre_indication':cIndication_trans,
              'precaution':precaution_trans,
              'interaction':interaction_trans,
              'surdosage':surdosage_trans,
              'grossesse':grossesse_trans,
              'langue': lang
            };

            print(data['surdosage']);
            print(option);
            print("ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg666666666666666666");

          }

          print("ici 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");

          print(data);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArView(
              data: data,
            )),
          );

          print("ici2 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");


        }
      });


    } catch (e) {
      print(e.toString());
    }


//...
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

        title: const Text("Langue"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            OutlinedButton.icon(
              icon: const Icon(Icons.cancel_schedule_send_outlined),
              label: const Text("Anglais."),
              onPressed: _text_to_speech, //For augmented reality page


              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: d_green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),


            OutlinedButton.icon(
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text("Français"),
              onPressed: () =>_startScan(1),

              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: d_green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),

            OutlinedButton.icon(
              icon: const Icon(Icons.camera_outlined),
              label: const Text("Baoulé   "),
              onPressed:() => _startScan(4),

              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: d_green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),


            OutlinedButton.icon(
              icon: const Icon(Icons.camera_outlined),
              label: const Text("Espagnol"),
              onPressed:() => _startScan(3),

              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2.0, color: d_green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


