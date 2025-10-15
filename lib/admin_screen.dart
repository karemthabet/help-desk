import 'package:cloud_task/auth_cubit.dart';
import 'package:cloud_task/auth_repository.dart';
import 'package:cloud_task/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  void _handleLogout(BuildContext context) async {
    final cubit = context.read<AuthCubit>();
    await cubit.logout();
    
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthCubit(authRepository: AuthRepository( )),
            child: LoginScreen(),
          ),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الأدمن'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'مرحباً بك في لوحة الأدمن',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
