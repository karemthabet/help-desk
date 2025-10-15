import 'package:cloud_task/cubits/auth_cubit.dart';
import 'package:cloud_task/screens/add_complaint_screen.dart';
import 'package:cloud_task/screens/admin_screen.dart';
import 'package:cloud_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is AuthLoggedIn) {
          if (state.profile!['role'] == 'admin') {
            return const AdminScreen();
          } else {
            return AddComplaintScreen();
          }
        }

        return LoginScreen();
      },
    );
  }
}
