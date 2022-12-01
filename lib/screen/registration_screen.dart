import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool loader = false;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.blue,
        title: Center(child: Text("Registration")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, top: 70),
              child: TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  hintText: "FirstName",
                  labelText: "FirstName",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28,),
              child: TextField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  hintText: "LastName",
                  labelText: "LastName",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, ),
              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: "Age",
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, ),
              child: TextField(
                controller: _occupationController,
                decoration: InputDecoration(
                  hintText: "Occupation",
                  labelText: "Occupation",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28,),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(
              height: 28,
            ),

           loader ? Center(child: CircularProgressIndicator(),):
           ElevatedButton(
                onPressed: () {
                  registration ();
                },
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }

  Future registration ()async{

    try{
      setState(() {
        loader = true;
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);

      // add user details..

      addUserDetails();

      Fluttertoast.showToast(
          msg: "Registration Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));

    }on FirebaseAuthException catch(errorMessage){

      setState(() {
        Fluttertoast.showToast(
            msg: "${errorMessage.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        loader = false;
      });

    }

  }

  Future addUserDetails() async{
    await FirebaseFirestore.instance.collection("users").add(
        {
          "first_name": _firstnameController.text,
          "last_name": _lastnameController.text,
          "age": _ageController.text,
          "occupation": _occupationController.text,
          
        }
    );
  }


}


