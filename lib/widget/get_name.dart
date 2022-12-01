import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetName extends StatelessWidget {
  final String? collectionId;
  const GetName({Key? key, this.collectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    CollectionReference _collectionReference = FirebaseFirestore.instance.collection("users");


    return Container(
      child: FutureBuilder<DocumentSnapshot?>(
          future: _collectionReference.doc(collectionId).get(),
        builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){
              Map<String,dynamic> data =  snapshot.data!.data()as  Map<String,dynamic>;
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child:  Text("${data["first_name"]}"),
              );



            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

        },
      ),
    );
  }
}
