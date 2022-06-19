import 'package:flutter/material.dart';
import 'package:opem/screens/register_screen.dart';
import 'package:opem/supabase/components/auhstate.dart';
import 'package:opem/supabase/functions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              SizedBox(height: 45,),
              Container(width:200,child: TextFormField(controller: emailET,)),
              Container(width:200,child: TextFormField(controller: passwordET,)),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){


                signIn(context,emailET.text, passwordET.text);
              }, child: Text("Login")),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                child:Text("Create account",style: TextStyle(fontSize: 9,fontWeight:FontWeight.bold),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
