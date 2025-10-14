import 'dart:io';
import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaint_model.dart';
import 'package:cloud_task/complaint_state.dart';
import 'package:cloud_task/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  File? _image;
  final _picker = ImagePicker();
  late ComplaintCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ComplaintCubit();
    cubit.fetchForUser();
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? f = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (f != null) setState(() => _image = File(f.path));
  }

  Future<void> _create() async {
    if (_title.text.trim().isEmpty) return; // minimal validation
    await cubit.createComplaint(
      title: _title.text.trim(),
      description: _desc.text.trim(),
      imageFile: _image,
    );
    _title.clear();
    _desc.clear();
    setState(() => _image = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Complaints'),
        actions: [
          IconButton(
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginSignupScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _desc,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Pick Image'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _create,
                      child: const Text('Send Complaint'),
                    ),
                  ],
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Image: ${_image!.path.split('/').last}'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ComplaintCubit, ComplaintState>(
              bloc: cubit,
              builder: (context, state) {
                if (state.loading)
                  return const Center(child: CircularProgressIndicator());
                if (state.error != null)
                  return Center(child: Text('Error: ${state.error}'));
                if (state.complaints.isEmpty)
                  return const Center(child: Text('No complaints yet'));
                return ListView.builder(
                  itemCount: state.complaints.length,
                  itemBuilder: (context, i) {
                    final Complaint c = state.complaints[i];
                    return ListTile(
                      title: Text(c.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.description),
                          Text('Status: ${c.status}'),
                          if (c.solution != null)
                            Text('Solution: ${c.solution}'),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
