import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  // final User user = _auth.currentUser!;
  //   get uid => user!.uid;
  late String messageText;
  late String email;

  // final user = <String, dynamic>{
  //   "text":   "test",
  //   "sender": "email",
  // };

  @override
  void initState() {
    super.initState();
    inputData();
  }

  Future<void> inputData() async{
    try {
       final User user = _auth.currentUser!;
       final _email = user.email;
      if (user != null) {
        email = _email!;
      }
    }
    catch(e){print(e);}
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value; //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                     onPressed: () async {
                      await _firestore.collection("messages").add({
                        "sender": email,
                        "text": messageText,
                      });
                      //   (user).then((DocumentReference doc) =>
                      // print('DocumentSnapshot added with ID: ${doc.id}'));
                    },
                     child: const Text(
                      'Send',
                       style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
