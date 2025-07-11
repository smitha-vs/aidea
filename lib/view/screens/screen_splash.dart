import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/constants/screen_responsive.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});
  @override
  Widget build(BuildContext context) {
    final ResponsiveHelper responsive = ResponsiveHelper(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Color(0xFF010F58), // Base dark blue (rich and bold)
              Color(0xFF0020A9), // Deep navy blue (darker accent)
              Color(0xFF0020A9), // Almost black-blue (bottom anchor)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: EdgeInsets.only(top:responsive.screenHeight *.2),
            child: Image.asset(
            'assets/images/gok_logo.png',
            height: 100,
            color: Colors.white,
                    ),
          ),
        const SizedBox(height: 16),
        const Text(
          'AIDEA',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Department of Economics & Statistics',
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'GOVERNMENT OF KERALA',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
            const SizedBox(height: 100),
            GestureDetector(
              onTap: (){
                Get.offAllNamed('/loginScreen');
              },
              child: Container(
                width:MediaQuery.of(context).size.width *.8,
                height: 60,
                 decoration: BoxDecoration(
                   color:Colors.white,
                  borderRadius: BorderRadius.circular(
                      20
                  ),
                ),
                child:
                Center(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(
                      color:  Color(0xFF0020A9),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),),
            )
        ])
      ),
    );
  }
}
