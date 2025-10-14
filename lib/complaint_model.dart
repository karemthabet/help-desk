class Complaint {
final String id;
final String userId;
final String title;
final String description;
final String? imagePath;
final String? solution;
final String status;
final DateTime createdAt;
final DateTime? resolvedAt;


Complaint({
required this.id,
required this.userId,
required this.title,
required this.description,
this.imagePath,
this.solution,
required this.status,
required this.createdAt,
this.resolvedAt,
});


factory Complaint.fromMap(Map<String, dynamic> m) {
return Complaint(
id: m['id'] as String,
userId: m['user_id'] as String,
title: m['title'] as String,
description: m['description'] as String? ?? '',
imagePath: m['image_path'] as String?,
solution: m['solution'] as String?,
status: m['status'] as String? ?? 'pending',
createdAt: DateTime.parse(m['created_at'] as String),
resolvedAt: m['resolved_at'] != null ? DateTime.parse(m['resolved_at'] as String) : null,
);
}


Map<String, dynamic> toMap() => {
'id': id,
'user_id': userId,
'title': title,
'description': description,
'image_path': imagePath,
'solution': solution,
'status': status,
'created_at': createdAt.toIso8601String(),
'resolved_at': resolvedAt?.toIso8601String(),
};
}