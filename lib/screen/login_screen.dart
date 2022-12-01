import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/screen/home_screen.dart';
import 'package:firebase_demo/screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool loader = false;
  bool checkPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.blue,
        title: Center(child: Text("Login")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28, right: 28, top: 110),
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
                obscureText: checkPassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                      onTap: (){
                        showPassword();
                      },
                      child: checkPassword ? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                ),
              ),
            ),

            SizedBox(
              height: 28,
            ),

            loader ? Center(child: CircularProgressIndicator(),):
            ElevatedButton(
                onPressed: () {
                  LoginMethod ();
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                )),

            SizedBox(height: 20,),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                },
                child: Text(
                  "Registration Page",
                  style: TextStyle(fontSize: 20),
                )),

          ],
        ),
      ),
    );
  }
  showPassword(){
setState(() {
  checkPassword  = !checkPassword;
});
  }



  Future LoginMethod() async{

    try{
      setState(() {
        loader = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);

      Fluttertoast.showToast(
          msg: "Login Successfull",
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


}


