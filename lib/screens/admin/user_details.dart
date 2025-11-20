import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/user_service.dart';

class UserDetails extends StatelessWidget {
  final AppUser user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${user.name}', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Email: ${user.email}'),
          const SizedBox(height: 8),
          Text('Phone: ${user.phone}'),
          const SizedBox(height: 8),
          Text('Role: ${user.role.toString().split('.').last}'),
          const SizedBox(height: 8),
          Text('Status: ${user.isApproved ? 'Approved' : 'Not Approved'}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  final updatedUser = user.copyWith(isApproved: true);
                  userService.updateUser(updatedUser);
                },
                child: const Text('Approve'),
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedUser = user.copyWith(isApproved: false);
                  userService.updateUser(updatedUser);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Disapprove'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
