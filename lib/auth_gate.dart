
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/user_service.dart';
import 'package:myapp/screens/auth/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          return FutureBuilder<AppUser?>(
            future: UserService().getUser(snapshot.data!.uid),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (userSnapshot.hasData) {
                final user = userSnapshot.data!;
                if (user.isApproved == false) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/waiting_for_approval');
                  });
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }

                switch (user.role) {
                  case UserRole.admin:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/admin_dashboard');
                    });
                    break;
                  case UserRole.murshid:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/murshid_dashboard');
                    });
                    break;
                  case UserRole.mureed:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/mureed_dashboard');
                    });
                    break;
                  default:
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/login');
                    });
                    break;
                }
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/login');
                });
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
            },
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
