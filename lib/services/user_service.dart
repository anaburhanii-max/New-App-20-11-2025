import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(AppUser user) {
    return _userCollection.doc(user.id).set(user.toMap());
  }

  Future<AppUser?> getUser(String id) async {
    final doc = await _userCollection.doc(id).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<AppUser>> getUsers() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> updateUser(AppUser user) {
    return _userCollection.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) {
    return _userCollection.doc(userId).delete();
  }

  Stream<List<AppUser>> getUnassignedUsers() {
    return _userCollection.where('silsilahId', isEqualTo: null).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<AppUser>> getSilsilahUsers(String silsilahId) {
    return _userCollection.where('silsilahId', isEqualTo: silsilahId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> assignUserToSilsilah(String userId, String silsilahId) {
    return _userCollection.doc(userId).update({'silsilahId': silsilahId});
  }

  Future<void> removeUserFromSilsilah(String userId) {
    return _userCollection.doc(userId).update({'silsilahId': null});
  }

  Stream<List<AppUser>> getApprovedMurshids() {
    return _userCollection
        .where('role', isEqualTo: 'murshid')
        .where('isApproved', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<AppUser>> getMureeds(String murshidId) {
    return _userCollection.where('murshidId', isEqualTo: murshidId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<AppUser>> getUsersBySilsilahs(List<String> silsilahIds) {
    return _userCollection.where('silsilahId', whereIn: silsilahIds).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
