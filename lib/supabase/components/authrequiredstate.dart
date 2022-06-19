import 'package:flutter/material.dart';
import 'package:opem/screens/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));

  }
}