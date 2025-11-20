import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserList extends StatelessWidget {
  final List<AppUser> users;
  final Function(AppUser) onUserSelected;

  const UserList({super.key, required this.users, required this.onUserSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.role.toString().split('.').last),
          onTap: () => onUserSelected(user),
        );
      },
    );
  }
}
