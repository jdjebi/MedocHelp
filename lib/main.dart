import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medoc/ArView/ArView.dart';
import 'package:device_preview/device_preview.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage/MedocSection.dart';
import 'HomePage/ScannerClass.dart';
import 'HomePage/SearchSection.dart';

const d_green = Color(0xFF54D3C2);

List<CameraDescription> cameras = <CameraDescription>[];

void main() {

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) {
      exit(1);
    }
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medoc-Help',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: DevicePreview.appBuilder,
      home: ResponsiveWrapper.builder(
        HomePage(),
        maxWidth: 1200,
        minWidth: 480,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(480, name: TABLET),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
            size: 20,
          ),
          onPressed: null,
        ),
        centerTitle: true,
        title: Text(
          'Medoc-Help',
          style: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.local_pharmacy_sharp,
              color: Colors.grey[800],
              size: 20,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.place,
              color: Colors.grey[800],
              size: 20,
            ),
            onPressed: null,
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SearchSection(),
            MedocSection(),
            const ScannerClass(),
            // const ScannerClass(),
          ],
        ),
      ),
    );
  }
}
