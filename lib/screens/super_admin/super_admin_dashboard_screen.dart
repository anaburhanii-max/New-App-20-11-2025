import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import './user_list.dart';
import './user_details.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  final UserService _userService = UserService();
  AppUser? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_work),
            onPressed: () {
              context.go('/silsilah-management');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_tree),
            onPressed: () {
              context.go('/silsilah-tree');
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<List<AppUser>>(
              stream: _userService.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final users = snapshot.data!;

                return UserList(
                  users: users,
                  onUserSelected: (user) {
                    setState(() {
                      _selectedUser = user;
                    });
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
