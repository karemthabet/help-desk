import 'package:cloud_task/complaint_cubit.dart';
import 'package:cloud_task/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ComplaintItem extends StatelessWidget {
  final ComplaintModel model;
  const ComplaintItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintsCubit>();

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: model.imageUrl != null
            ? Image.network(model.imageUrl!, width: 50, fit: BoxFit.cover)
            : const Icon(Icons.report_problem),
        title: Text(model.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.description),
            const SizedBox(height: 4),
            Text('الحالة: ${model.status}', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (model.adminComment != null)
              Text('رد الأدمن: ${model.adminComment!}', style: const TextStyle(color: Colors.green)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (v) => cubit.updateStatus(model.id, v),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'done', child: Text('تم الحل')),
            PopupMenuItem(value: 'not_done', child: Text('لم يتم الحل')),
          ],
        ),
      ),
    );
  }
}
