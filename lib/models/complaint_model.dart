class ComplaintModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String status;
  final String createdAt;
  final String? adminComment;

  ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.status,
    required this.createdAt,
    this.adminComment,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      status: json['status'] ?? 'pending',
      createdAt: json['created_at'] ?? '',
      adminComment: json['admin_comment'],
    );
  }
}
