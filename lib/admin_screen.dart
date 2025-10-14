import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaint_model.dart';
import 'package:cloud_task/complaint_state.dart';
import 'package:cloud_task/login_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late ComplaintCubit cubit;
  final _solutionCtr = TextEditingController();
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    cubit = ComplaintCubit();
    cubit.fetchAll();
  }

  @override
  void dispose() {
    _solutionCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Complaints'),
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
                      onTap: () {
                        setState(() {
                          _selectedId = c.id;
                          _solutionCtr.text = c.solution ?? '';
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          if (_selectedId != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _solutionCtr,
                      decoration: const InputDecoration(labelText: 'Solution'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_selectedId != null)
                        await cubit.setSolution(
                          _selectedId!,
                          _solutionCtr.text,
                        );
                      setState(() {
                        _selectedId = null;
                        _solutionCtr.clear();
                      });
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
