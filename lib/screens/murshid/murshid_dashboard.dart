import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../providers/theme_provider.dart';

class MurshidDashboard extends StatelessWidget {
  const MurshidDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreService = FirestoreService();
    final murshidId = authProvider.user!.id;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Murshid Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().signOut();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('Mureeds'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getMureeds(murshidId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final mureeds = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: mureeds.length,
                  itemBuilder: (context, index) {
                    final mureed = mureeds[index];
                    return ListTile(
                      title: Text(mureed['name'] ?? 'N/A'),
                      subtitle: Text(mureed['email'] ?? 'N/A'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
