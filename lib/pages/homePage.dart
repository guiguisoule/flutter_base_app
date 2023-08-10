// ignore_for_file: file_names, unused_import

import 'package:base_app/pages/eventPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Image.asset('assets/images/SYS dev-soft.jpg')),
            const Text(
              "Bienvenue",
              style: TextStyle(
                fontSize: 45,
                fontFamily: 'Poppins'
              ),
            ),
            const Text("L'application qui sera untilise comme base"),
            Container(
              margin: const EdgeInsets.all(20),
              height: 150,
              child: SvgPicture.asset('assets/images/undraw.svg')
            ),
            const Padding(padding: EdgeInsets.all(20)),
            
            // button avec icone 
            // ElevatedButton.icon(
            //   style: const ButtonStyle(
            //     backgroundColor: MaterialStatePropertyAll(Colors.green)
            //   ),
            //   onPressed: () => {
            //     Navigator.push(
            //       context, 
            //       PageRouteBuilder(
            //         pageBuilder: (_,__,___) => const EventPage()
            //     ))
            //   }, 
            //   icon: const Icon(Icons.calendar_month), 
            //   label: const Text('Evenement')
            // ),
          ],
        )
      );
  }
}