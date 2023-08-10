// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  // le formKey permet d'enregistrer tout les saisis des champs du formulare 
  final _formKey = GlobalKey<FormState>();

  // initialisation des controlleurs
  final confNameController = TextEditingController();
  final profNameController = TextEditingController();
  String selectedConfType = 'demo';
  DateTime selectedDateConf = DateTime.now();
  String avatarController = 'avatar';

  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    profNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        // definition de la cle du formulaire
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom Conference',
                  hintText: 'Entrer le nom de la conference',
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'se champ est obligatoir';
                  }
                  return null;
                },
                // mise en relation du textFormField et du controller
                controller: confNameController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom du prof',
                  hintText: 'Entrer le nom du prof',
                  border: OutlineInputBorder()
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'se champ est obligatoir';
                  }
                  return null;
                },
                controller: profNameController,
              ),
            ),
            // select list
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'demo',child: Text("Demo code")),
                  DropdownMenuItem(value: 'partenaire',child: Text("Partenaire")),
                  DropdownMenuItem(value: 'autre',child: Text("Autre")),
                ], 
                value: selectedConfType,
                onChanged: (value) {
                  // le setState permaire de rafraichire l'ecren en lui donnane de nouvelle valeurs
                  setState(() {
                    selectedConfType = value!;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Choisir la date',
                ),
                // mode de recuperation de la date (date - time - dateAndTime)
                mode: DateTimeFieldPickerMode.dateAndTime,
                autovalidateMode: AutovalidateMode.always,
                validator: (DateTime? e) {
                  return (e?.day ?? 0) == 1
                      ? 'Please not the first day'
                      : null;
                },
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedDateConf = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Envoyer'), 
                onPressed: (){
                  // verification du formulaire suivant les validator defini pour chaque textFormField
                  if (_formKey.currentState!.validate()) {

                    // recuperation des valeurs saisi dans le formulaire
                    final sujet = confNameController.text;
                    final prof = profNameController.text;
                    // final avatar = 


                    // affichage d'une alerte
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Envoi en cours...'))
                    );
                    // fermeture du clavie apres soumission du formulaire
                    FocusScope.of(context).requestFocus(FocusNode());

                    // affichage console
                    // ignore: avoid_print
                    // print("Sujet : $sujet >Prof : $prof");

                    // ajout dans la firebase
                    CollectionReference eventRef = FirebaseFirestore.instance.collection('Events');
                    eventRef.add({
                      'prof': prof,
                      'date': selectedDateConf,
                      'sujet': sujet,
                      'type': selectedConfType,
                      'avatar': 'avatar'
                    });
                  }
                }
              ),
            ),
          ],
        )
      ),
    );
  }
}