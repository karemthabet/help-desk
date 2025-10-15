import 'package:cloud_task/app_wrapper.dart';
import 'package:cloud_task/cubits/auth_cubit.dart';
import 'package:cloud_task/repos/auth_repository.dart';
import 'package:cloud_task/cubits/complaint_cubit.dart';
import 'package:cloud_task/repos/complaints_repo.dart';
import 'package:cloud_task/core/theme/app_theme.dart';
import 'package:cloud_task/core/utils/constants.dart';
import 'package:cloud_task/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



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

