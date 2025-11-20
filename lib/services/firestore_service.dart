import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getTasks(String mureedId) {
    return _db
        .collection('tasks')
        .where('assignedTo', isEqualTo: mureedId)
        .snapshots();
  }

  Stream<QuerySnapshot> getMureeds(String murshidId) {
    return _db
        .collection('users')
        .where('murshid', isEqualTo: murshidId)
        .snapshots();
  }

  Stream<QuerySnapshot> getRejectedMurshids() {
    return _db
        .collection('users')
        .where('role', isEqualTo: 'murshid')
        .where('status', isEqualTo: 'rejected')
        .snapshots();
  }

  Stream<QuerySnapshot> getRejectedMureeds() {
    return _db
        .collection('users')
        .where('role', isEqualTo: 'mureed')
        .where('status', isEqualTo: 'rejected')
        .snapshots();
  }

  Stream<QuerySnapshot> getMurshidRequests() {
    return _db.collection('murshid_requests').snapshots();
  }

  Future<void> approveMurshid(String murshidId, String requestId) async {
    await _db.collection('users').doc(murshidId).update({'status': 'approved'});
    await _db.collection('murshid_requests').doc(requestId).delete();
  }

  Future<void> rejectMurshid(String murshidId, String requestId) async {
    await _db.collection('users').doc(murshidId).update({'status': 'rejected'});
    await _db.collection('murshid_requests').doc(requestId).delete();
  }
}
