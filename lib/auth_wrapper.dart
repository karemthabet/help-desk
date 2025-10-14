import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:cloud_task/admin_screen.dart';
import 'package:cloud_task/user_screen.dart';
import 'package:cloud_task/login_signup_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      _checkAuthState();
    });
  }

  Future<void> _checkAuthState() async {
    setState(() => _isLoading = true);
    final user = SupabaseService.client.auth.currentUser;

    if (user == null) {
      setState(() => _isLoading = false);
      return;
    }

    Map<String, dynamic>? profile;
    for (int i = 0; i < 5; i++) {
      profile = await SupabaseService.getUserProfile();
      if (profile != null) break;
      await Future.delayed(const Duration(seconds: 1));
    }

    final isAdmin = profile != null && profile['role'] == 'admin';
    
    setState(() {
      _isAdmin = isAdmin;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = SupabaseService.client.auth.currentUser;
    if (user == null) return const LoginSignupScreen();

    return _isAdmin ? const AdminScreen() : const UserScreen();
  }
}
