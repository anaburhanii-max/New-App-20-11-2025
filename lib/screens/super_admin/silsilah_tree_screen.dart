import 'package:flutter/material.dart';
import '../../models/silsilah.dart';
import '../../services/silsilah_service.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class SilsilahTreeScreen extends StatelessWidget {
  const SilsilahTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SilsilahService silsilahService = SilsilahService();
    final UserService userService = UserService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Silsilah Tree'),
      ),
      body: StreamBuilder<List<Silsilah>>(
        stream: silsilahService.getSilsilahs(),
        builder: (context, silsilahSnapshot) {
          if (silsilahSnapshot.hasError) {
            return Center(child: Text('Error: ${silsilahSnapshot.error}'));
          }
          if (silsilahSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final silsilahs = silsilahSnapshot.data ?? [];

          return StreamBuilder<List<AppUser>>(
            stream: userService.getUsers(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasError) {
                return Center(child: Text('Error: ${userSnapshot.error}'));
              }
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final allUsers = userSnapshot.data ?? [];
              final userMap = {for (var user in allUsers) user.id: user};

              return ListView.builder(
                itemCount: silsilahs.length,
                itemBuilder: (context, index) {
                  final silsilah = silsilahs[index];
                  return ExpansionTile(
                    title: Text(silsilah.name),
                    subtitle: Text(silsilah.description),
                    children: silsilah.members.map((memberId) {
                      final user = userMap[memberId];
                      return ListTile(
                        title: Text(user?.name ?? 'Unknown User'),
                        subtitle: Text(user?.email ?? ''),
                        leading: const Icon(Icons.person),
                      );
                    }).toList(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
