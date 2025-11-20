import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String mureedId;
  final String murshidId;
  final String title;
  final int count;
  final String type;
  final String status;
  final Timestamp timestamp;

  TaskModel({
    required this.id,
    required this.mureedId,
    required this.murshidId,
    required this.title,
    required this.count,
    required this.type,
    required this.status,
    required this.timestamp,
  });

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      mureedId: data['mureedId'] ?? '',
      murshidId: data['murshidId'] ?? '',
      title: data['title'] ?? '',
      count: data['count'] ?? 0,
      type: data['type'] ?? '',
      status: data['status'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
