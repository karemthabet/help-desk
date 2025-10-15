import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaint_item.dart';
import 'package:cloud_task/complaint_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintsListScreen extends StatelessWidget {
  const ComplaintsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('شكاواي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/add'),
          )
        ],
      ),
      body: BlocBuilder<ComplaintsCubit, ComplaintsState>(
        builder: (context, state) {
          if (state is ComplaintsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ComplaintsLoaded) {
            if (state.complaints.isEmpty) {
              return const Center(child: Text('لا توجد شكاوى بعد'));
            }
            return ListView.builder(
              itemCount: state.complaints.length,
              itemBuilder: (context, i) => ComplaintItem(model: state.complaints[i]),
            );
          }
          return const Center(child: Text('حدث خطأ'));
        },
      ),
    );
  }
}
