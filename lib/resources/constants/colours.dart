import 'package:flutter/material.dart';

class AppColour {
  static const Color themeColour = Color(0xff05307A);
  static const Color whiteColour = Color(0xffffffff);
  static const Color blackColour = Color(0xff000000);
  static const Color scaffoldColour=Color(0xffF1F4FF);
  static const Color earlsGreenColour=Color(0xFFC2AA27);
  static const Color springGreenColour=Color(0xFF12EAA2);
  static const Color aliZarinColour=Color(0xffF93440);
  static const Color greyColour=Color(0xff808080);
  static const Color secondaryTextColor = Color(0xff444648);
  static const Color backgroundColor = Color(0xFFE3F2FD);
  static const Color desBlueColor = Color(0xFF021D7B);
  static const Color iconColor = Color(0xFF021D7B);
  static const Color newsColor=Color(0xFFb8cfe5);


  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(255, 110, 97, 0.57),
      Color.fromRGBO(255, 128, 109, 1),
    ],
  );
  static const LinearGradient themeGradient = LinearGradient(
    colors: [
      Color(0xFF2A6EC1), // #2A6EC1
      Color(0xFF164D9B), // #164D9B
      Color(0xFF0E3F8B), // #0E3F8B
      Color(0xFF05307A), // #05307A
    ],
    stops: [0.15, 0.28, 0.41, 0.64],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient schemeGradient = LinearGradient(
    colors: [
      Colors.yellow,
      Colors.red,
      Colors.indigo,
      Colors.teal,
    ],
    stops: [
      0.1,
      0.4,
      0.6,
      0.9,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient lavenderGradient = LinearGradient(
    colors: [
      Color(0xFFEFEBFD), // #2A6EC1
      Color(0xFFECE5FD), // #164D9B
      Color(0xFFEDE1FD), // #0E3F8B
      Color(0xFFEEDFFC),
    ],
    stops: [
      0.1,
      0.4,
      0.6,
      0.9,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
