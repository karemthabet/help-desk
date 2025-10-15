import 'package:cloud_task/screens/add_complaint_screen.dart';
import 'package:cloud_task/screens/admin_screen.dart';

import 'package:cloud_task/supabase_service.dart';
import 'package:flutter/material.dart';

class AuthCheck {
  static Future<String?> getUserRole() async {
    final userId = SupabaseService.userId;
    if (userId == null) return null;

    try {
      final response =
          await SupabaseService.client
              .from('profiles')
              .select('role')
              .eq('id', userId)
              .maybeSingle();

      return response?['role'] as String?;
    } catch (e) {
      return null;
    }
  }

  static Future<void> navigateBasedOnRole(BuildContext context) async {
    final role = await getUserRole();

    if (!context.mounted) return;

    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AdminScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AddComplaintScreen()),
      );
    }
  }
}
