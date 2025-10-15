import 'dart:io';
import 'package:cloud_task/cubits/auth_cubit.dart';
import 'package:cloud_task/repos/auth_repository.dart';
import 'package:cloud_task/cubits/complaint_cubit.dart';
import 'package:cloud_task/cubits/complaint_state.dart';
import 'package:cloud_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _handleLogout() async {
    final cubit = context.read<AuthCubit>();
    await cubit.logout();

    if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('إرسال شكوى'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: BlocConsumer<ComplaintsCubit, ComplaintsState>(
        listener: (context, state) {
          if (state is ComplaintsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ComplaintsLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ تم إرسال الشكوى بنجاح')),
            );
            _titleCtrl.clear();
            _descCtrl.clear();
            setState(() => _image = null);
          }
        },
        builder: (context, state) {
          final isLoading = state is ComplaintsLoading;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                TextField(
                  controller: _titleCtrl,
                  decoration: const InputDecoration(labelText: 'عنوان الشكوى'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descCtrl,
                  maxLines: 5,
                  decoration:
                      const InputDecoration(labelText: 'تفاصيل الشكوى'),
                ),
                const SizedBox(height: 10),
                _image != null
                    ? Image.file(_image!, height: 150)
                    : const Text('لم يتم اختيار صورة'),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text('اختيار صورة'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => cubit.addComplaint(
                            title: _titleCtrl.text.trim(),
                            description: _descCtrl.text.trim(),
                            imageFile: _image,
                          ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('إرسال'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
