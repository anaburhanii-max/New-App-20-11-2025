import 'package:go_router/go_router.dart';
import 'package:myapp/auth_gate.dart';
import 'package:myapp/screens/admin/admin_dashboard_screen.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/mureed_signup_screen.dart';
import 'package:myapp/screens/auth/murshid_signup_screen.dart';
import 'package:myapp/screens/auth/waiting_for_approval_screen.dart';
import 'package:myapp/screens/mureed/mureed_dashboard_screen.dart';
import 'package:myapp/screens/murshid/murshid_dashboard_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/mureed_signup',
      builder: (context, state) => const MureedSignupScreen(),
    ),
    GoRoute(
      path: '/murshid_signup',
      builder: (context, state) => const MurshidSignupScreen(),
    ),
    GoRoute(
      path: '/waiting_for_approval',
      builder: (context, state) => const WaitingForApprovalScreen(),
    ),
    GoRoute(
      path: '/admin_dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/mureed_dashboard',
      builder: (context, state) => const MureedDashboardScreen(),
    ),
    GoRoute(
      path: '/murshid_dashboard',
      builder: (context, state) => const MurshidDashboardScreen(),
    ),
  ],
);
