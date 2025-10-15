import 'package:cloud_task/cubits/auth_cubit.dart';
import 'package:cloud_task/repos/auth_repository.dart';
import 'package:cloud_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authCubit = context.read<AuthCubit>();

    await authCubit.logout();

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AuthCubit(authRepository: AuthRepository()),
          child:  LoginScreen(),
        ),
      ),
      (route) => false,
    );
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
