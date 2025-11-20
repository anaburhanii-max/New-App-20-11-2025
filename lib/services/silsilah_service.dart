import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/silsilah.dart';

class SilsilahService {
  final CollectionReference _silsilahCollection = FirebaseFirestore.instance.collection('silsilahs');

  Future<void> addSilsilah(Silsilah silsilah) {
    return _silsilahCollection.add({
      'name': silsilah.name,
      'description': silsilah.description,
    });
  }

  Stream<List<Silsilah>> getSilsilahs() {
    return _silsilahCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Silsilah.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> updateSilsilah(Silsilah silsilah) {
    return _silsilahCollection.doc(silsilah.id).update(silsilah.toMap());
  }

  Future<void> deleteSilsilah(String silsilahId) {
    return _silsilahCollection.doc(silsilahId).delete();
  }

  Stream<List<Silsilah>> getSilsilahsByAdmin(String adminId) {
    return _silsilahCollection.where('adminId', isEqualTo: adminId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Silsilah.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }
}
