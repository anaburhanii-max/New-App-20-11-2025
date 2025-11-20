import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/user_service.dart';

class MureedDashboardScreen extends StatefulWidget {
  const MureedDashboardScreen({super.key});

  @override
  State<MureedDashboardScreen> createState() => _MureedDashboardScreenState();
}

class _MureedDashboardScreenState extends State<MureedDashboardScreen> {
  final UserService _userService = UserService();
  late Future<AppUser?> _murshidFuture;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _murshidFuture = _userService.getUser(authProvider.user!.murshidId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mureed Dashboard'),
      ),
      body: Center(
        child: FutureBuilder<AppUser?>(
          future: _murshidFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Error loading murshid data');
            }
            final murshid = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Mureed!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Murshid is: ${murshid?.name ?? 'Not Assigned'}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
