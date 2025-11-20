import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class SilsilahUsersScreen extends StatelessWidget {
  final String silsilahId;

  const SilsilahUsersScreen({super.key, required this.silsilahId});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Silsilah Users'),
      ),
      body: StreamBuilder<List<AppUser>>(
        stream: userService.getSilsilahUsers(silsilahId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.role.toString().split('.').last),
              );
            },
          );
        },
      ),
    );
  }
}
