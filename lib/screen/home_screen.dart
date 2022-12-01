import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/get_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final userdata = FirebaseAuth.instance.currentUser;

  List<String> documentInformation = [];

  Future getDocumentdata() async{
    await FirebaseFirestore.instance.collection("users").get().then((docdata) {
      docdata.docs.forEach((element) {
        documentInformation.add(element.reference.id);
      });
      setState(() {

      });

    });
  }
  @override
  void initState() {
    getDocumentdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Center(child: Text("Home")),
        backgroundColor: Colors.blue,
      ),

      body:ListView.builder(
            itemCount: documentInformation.length,
            itemBuilder: (_,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: GetName(
                    collectionId:documentInformation[index] ,
                  ),
                ),
              );
            },
      )
    );
  }
}
