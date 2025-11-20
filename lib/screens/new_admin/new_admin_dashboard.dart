import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../providers/theme_provider.dart';

class NewAdminDashboard extends StatelessWidget {
  const NewAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Admin Dashboard'),
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
          const Text('Rejected Murshids'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getRejectedMurshids(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final murshids = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: murshids.length,
                  itemBuilder: (context, index) {
                    final murshid = murshids[index];
                    return ListTile(title: Text(murshid['name'] ?? 'N/A'));
                  },
                );
              },
            ),
          ),
          const Text('Rejected Mureeds'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getRejectedMureeds(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final mureeds = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: mureeds.length,
                  itemBuilder: (context, index) {
                    final mureed = mureeds[index];
                    return ListTile(title: Text(mureed['name'] ?? 'N/A'));
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
