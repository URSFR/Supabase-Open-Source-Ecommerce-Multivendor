import 'package:flutter/material.dart';
import 'package:opem/screens/login_screen.dart';
import 'package:opem/supabase/functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  TextEditingController emailET = TextEditingController();
  TextEditingController passwordET = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 45,
              ),
              Container(width: 200,child: TextFormField(controller: emailET,)),
              Container(width: 200,child: TextFormField(controller: passwordET,)),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){
                signUp(context,emailET.text, passwordET.text);
              }, child: Text("Register")),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child:Text("Already registered?",style: TextStyle(fontSize: 9,fontWeight:FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
