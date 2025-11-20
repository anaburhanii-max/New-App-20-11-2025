import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_service.dart';

class MurshidDashboardScreen extends StatefulWidget {
  const MurshidDashboardScreen({super.key});

  @override
  State<MurshidDashboardScreen> createState() => _MurshidDashboardScreenState();
}

class _MurshidDashboardScreenState extends State<MurshidDashboardScreen> {
  final UserService _userService = UserService();
  late Stream<List<AppUser>> _mureedsStream;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _mureedsStream = _userService.getMureeds(authProvider.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murshid Dashboard'),
      ),
      body: StreamBuilder<List<AppUser>>(
        stream: _mureedsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading mureeds'));
          }
          final mureeds = snapshot.data ?? [];
          return ListView.builder(
            itemCount: mureeds.length,
            itemBuilder: (context, index) {
              final mureed = mureeds[index];
              return ListTile(
                title: Text(mureed.name),
                subtitle: Text(mureed.email),
              );
            },
          );
        },
      ),
    );
  }
}
