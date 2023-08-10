// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        // stream: FirebaseFirestore.instance.collection('Events').where('type', isEqualTo: 'demo').snapshots(),
        // stream: FirebaseFirestore.instance.collection('Events').orderBy('date', descending: true).snapshots(),
        // stream: FirebaseFirestore.instance.collection('Events').orderBy('date', descending: false).snapshots(),
        stream: FirebaseFirestore.instance.collection('Events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          // Spiner d'attente de chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
    
          // message en cas de liste vide
          if(!snapshot.hasData){
            return const Text("Aucun evenement");
          }
    
          // recuperation de la liste
          List<dynamic> events = [];
          snapshot.data!.docs.forEach((element) {
            events.add(element);
          });
    
          return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
    
                final avatar = event['avatar'].toString().toLowerCase();
                final prof = event['prof'];
                final sujet = event['sujet'];
                // formatage de la date
                final Timestamp timesrtamp = event['date'];
                String date = DateFormat.yMMMMd('en_US').format(timesrtamp.toDate());


                return Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/$avatar.png'),
                    title: Text('$prof ($date)'),
                    subtitle: Text('$sujet'),
                    trailing: const Icon(Icons.more_vert),
                  ),
                );
              },
            );
        }
      ),
    );
  }
}