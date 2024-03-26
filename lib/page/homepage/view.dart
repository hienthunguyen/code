import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gemini_api_app/page/homepage/controller.dart';
import 'package:get/get.dart';

// class Homepage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       );
//   }
// }

class Homepage extends GetView<HomepageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Container(
            color: Colors.black.withOpacity(0.75), // Độ trong suốt của màu đen (0.75 là 75%)
            width: double.infinity,
            height: double.infinity,
          ),
              controller.pages[controller.state.selectedIndex.value],
            ],
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
            decoration: BoxDecoration(
              color: const Color.fromARGB(128, 60, 89, 156),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: BottomNavigationBar(
                  currentIndex: controller.state.selectedIndex.value,
                  onTap: controller.onItemTapped,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  selectedFontSize: 14,
                  unselectedFontSize: 12,
                  backgroundColor: Colors.transparent,
                  items: const [
                    BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                      label: 'Talk',
                    ),
                     BottomNavigationBarItem(
                    icon: Icon(Icons.text_snippet_rounded),
                      label: 'Text',
                    ),
                     BottomNavigationBarItem(
                      icon: Icon(Icons.image),
                      label: 'Camera',
                    ),
                  ],
                ),
              ),
            ),
          ),
          extendBody: true,
        ));
  }
}
