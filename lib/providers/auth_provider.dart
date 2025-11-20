import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/user_service.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  AppUser? _user;
  AppUser? get user => _user;

  bool get isLoggedIn => _user != null;
  bool get isApproved => _user?.isApproved ?? false;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
    } else {
      _user = await _userService.getUser(firebaseUser.uid);
    }
    notifyListeners();
  }

  Future<void> signUpMurshid(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final creds = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final newUser = AppUser(
      id: creds.user!.uid,
      name: name,
      email: email,
      phone: phone,
      role: UserRole.murshid,
    );
    await _userService.createUser(newUser);
    _user = newUser;
    notifyListeners();
  }

  Future<void> signUpMureed(
    String name,
    String email,
    String mobile,
    String password,
    String murshidId,
  ) async {
    final creds = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final newUser = AppUser(
      id: creds.user!.uid,
      name: name,
      email: email,
      phone: mobile,
      role: UserRole.mureed,
      murshidId: murshidId,
    );
    await _userService.createUser(newUser);
    _user = newUser;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
