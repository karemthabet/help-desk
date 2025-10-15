import 'package:cloud_task/add_complaint_screen.dart';
import 'package:cloud_task/auth_cubit.dart';
import 'package:cloud_task/auth_repository.dart';
import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaints_repo.dart';
import 'package:cloud_task/core/theme/app_theme.dart';
import 'package:cloud_task/core/utils/constants.dart';
import 'package:cloud_task/shared/widgets/loading_indicator.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create:
                (context) =>
                    AuthCubit(authRepository: context.read<AuthRepository>())
                      ..checkAuthStatus(),
          ),
          BlocProvider(create: (_) => ComplaintsCubit(
            repo: ComplaintsRepo(),
            authRepository: AuthRepository(),
          )),
        ],
        child: MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const AppWrapper(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

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
          return const Scaffold(body: Center(child: LoadingIndicator()));
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
