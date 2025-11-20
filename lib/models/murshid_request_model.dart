import 'package:cloud_firestore/cloud_firestore.dart';

class MurshidRequestModel {
  final String id;
  final String murshidId;
  final String status;

  MurshidRequestModel({
    required this.id,
    required this.murshidId,
    required this.status,
  });

  factory MurshidRequestModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MurshidRequestModel(
      id: doc.id,
      murshidId: data['murshidId'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
