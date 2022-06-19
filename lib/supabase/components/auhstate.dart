import 'package:flutter/material.dart';
import 'package:opem/screens/buy_screen.dart';
import 'package:opem/screens/register_screen.dart';
import 'package:supabase/supabase.dart' as supabase;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
  }

  @override
  void onAuthenticated(supabase.Session session) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BuyScreen()));
  }

  @override
  void onPasswordRecovery(supabase.Session session) {
    Navigator.pushNamedAndRemoveUntil(
        context, '/profile/changePassword', (route) => false);
  }

  @override
  void onErrorAuthenticating(String message) {
    print('***** onErrorAuthenticating: $message');
  }
}