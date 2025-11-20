import 'package:cloud_firestore/cloud_firestore.dart';

class MureedRequestModel {
  final String id;
  final String mureedId;
  final String murshidId;
  final String status;

  MureedRequestModel({
    required this.id,
    required this.mureedId,
    required this.murshidId,
    required this.status,
  });

  factory MureedRequestModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MureedRequestModel(
      id: doc.id,
      mureedId: data['mureedId'] ?? '',
      murshidId: data['murshidId'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
