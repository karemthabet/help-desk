import 'package:cloud_task/add_complaint_screen.dart';
import 'package:cloud_task/admin_screen.dart';
import 'package:cloud_task/auth_cubit.dart';
import 'package:cloud_task/auth_repository.dart';
import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaints_repo.dart';
import 'package:cloud_task/login_screen.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCheck {
  static Future<String?> getUserRole() async {
    final userId = SupabaseService.userId;
    if (userId == null) return null;

    try {
      final response = await SupabaseService.client
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

    final authCubit = context.read<AuthCubit>();

    if (role == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const AdminScreen(),
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authCubit),
              BlocProvider(create: (_) => ComplaintsCubit(
                repo: ComplaintsRepo(),
                authRepository: AuthRepository(),
              )),
            ],
            child:  AddComplaintScreen(),
          ),
        ),
      );
    }
  }
}
