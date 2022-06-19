import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opem/provider/user_provider.dart';
import 'package:opem/screens/buy_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as proveedor;

Future<void> signIn(context,String email, String password) async {
  var userProvider = proveedor.Provider.of<UserProvider>(context, listen: false);

  final response = await Supabase.instance.client.auth.signIn(email: email, password: password);
  if (response.error != null) {

    Fluttertoast.showToast(msg: "ERROR: "+response.error!.message);
    /// Handle error
  } else {
    userProvider.email = response.user!.email;
    userProvider.ID=  response.user!.id;
    Fluttertoast.showToast(msg: "SUCCESS");
    Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyScreen()));
    /// Sign in with success
  }
}

Future<void> signUp(context,String email, String password) async {
  var userProvider = proveedor.Provider.of<UserProvider>(context, listen: false);

  final response = await Supabase.instance.client.auth.signUp(email, password);
  if (response.error != null) {
    Fluttertoast.showToast(msg: "ERROR: "+ response.error!.message);
    /// Handle error
  } else {
   userProvider.email = response.user!.email;
   userProvider.ID=  response.user!.id;
    Fluttertoast.showToast(msg: "SUCCESS");
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyScreen()));
    /// Sign in with success
  }
}


// Future<void> addData(context,String email, String password) async {
//   final response = await Supabase.instance.client.from("TEST").insert({
//     "test":"test",
//   }).execute().whenComplete(() {
//     Fluttertoast.showToast(msg: "ADDED");
//   });
// }
//
// Future<void> readData(context,String email, String password) async {
//   final response = await Supabase.instance.client.from("TEST").select().execute().whenComplete(() {
//     Fluttertoast.showToast(msg: "READED");
//
//   });
// }
//
//
// Future<void> updateData(context,String email, String password) async {
//   final response = await Supabase.instance.client.from("TEST").update({
//     "test":"test2",
//   }).execute().whenComplete(() {
//     Fluttertoast.showToast(msg: "UPDATED");
//   });
// }
//
// Future<void> deleteData(context,String email, String password) async {
//   final response = await Supabase.instance.client.from("TEST").delete().execute().whenComplete(() {
//     Fluttertoast.showToast(msg: "DELETED");
//   });
// }