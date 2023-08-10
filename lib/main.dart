import 'package:base_app/pages/eventPage.dart';
import 'package:base_app/pages/addEventPage.dart';
import 'package:base_app/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  // initialisation du firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  setCurrentIndex(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // mise a joure du titre en fonction de la page selectionne
          title: [
            const Text("Home"),
            const Text("Event"),
            const Text("Formulaire")
          ][_currentIndex],
          ),

        // appel des page suivant l'ordre d'affichage et en fonction de la selection au menus 
        body: const [
          HomePage(),
          EventPage(),
          AddEventPage()
        ][_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          // Recuperation de l'index de la page selectionne dans la barre de menus
          currentIndex: _currentIndex,
          onTap: (index) {
            setCurrentIndex(index);
          },

          // Propriete de la barre de menus 
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          iconSize: 32,
          elevation: 10,
          // fixer le type d'affichage de la bare de navigation
          type: BottomNavigationBarType.fixed,

          // Definition des items du menus
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Event'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Formulaire'
            )
          ]
        ),
      )
    );
  }
}

