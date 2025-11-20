
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/silsilah.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/silsilah_service.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/screens/admin/user_list.dart';
import 'package:myapp/screens/admin/user_details.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final UserService _userService = UserService();
  final SilsilahService _silsilahService = SilsilahService();
  AppUser? _selectedUser;

  @override
  Widget build(BuildContext context) {
    final adminId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<List<Silsilah>>(
              stream: _silsilahService.getSilsilahsByAdmin(adminId),
              builder: (context, silsilahSnapshot) {
                if (silsilahSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (silsilahSnapshot.hasError) {
                  return const Center(child: Text('Error loading silsilahs'));
                }
                final silsilahs = silsilahSnapshot.data ?? [];
                final silsilahIds = silsilahs.map((s) => s.id).toList();

                return StreamBuilder<List<AppUser>>(
                  stream: _userService.getUsersBySilsilahs(silsilahIds),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userSnapshot.hasError) {
                      return const Center(child: Text('Error loading users'));
                    }
                    final users = userSnapshot.data ?? [];
                    return UserList(
                      users: users,
                      onUserSelected: (user) {
                        setState(() {
                          _selectedUser = user;
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: _selectedUser != null
                ? UserDetails(user: _selectedUser!)
                : const Center(child: Text('Select a user to see details')),
          ),
        ],
      ),
    );
  }
}
