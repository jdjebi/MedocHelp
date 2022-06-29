import 'dart:core';
import 'dart:core';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vector_math/vector_math_64.dart' as vector;



class ArViewController extends StatelessWidget {

  ArViewController({Key? key, required this.data}) : super(key: key);

  var data = {};

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        SizedBox(height: 40),
        ArControllerButton(label: "1",data: {
          'text': data["Indication"],
          'langue': data["langue"]
        }),
        SizedBox(height: 10),
        ArControllerButton(label: "2",data: {
          'text': data["posologie"],
          'langue': data["langue"]
        }),
        SizedBox(height: 10),
        ArControllerButton(label: "3", data: {
          'text': data["effet"],
          'langue': data["langue"]
        }),
        SizedBox(height: 10),
        ArControllerButton(label: "?", data: {
          'text': data["effet"],
          'langue': data["langue"]
        })
      ],
    );



  }
}

class ArControllerButton extends StatelessWidget{

  final String label;

  var data;

  ArControllerButton({Key? key,required this.label, required this.data}) : super(key: key);

  _text_to_speech(var data){
    TextToSpeech tts = TextToSpeech();
    tts.setLanguage(data["langue"].toString());
    double volume = 1.0;
    tts.setVolume(volume);
    double rate = 0.7;
    tts.setRate(rate);
    tts.speak(data["text"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //Makes it usable on any background color, thanks @IanSmith
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            //This keeps the splash effect within the circle
            onTap: (){
              print(data);
              _text_to_speech(data);
            },
            borderRadius: BorderRadius.circular(1000.0), //Something large to ensure a circle
            child: Padding(
              padding:EdgeInsets.all(10.0),
              child: Text(this.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          ),
        )
    );
  }
  
}