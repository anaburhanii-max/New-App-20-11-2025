import 'package:go_router/go_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/screens/admin/admin_dashboard_screen.dart';
import 'package:myapp/screens/auth/login_screen.dart';
import 'package:myapp/screens/auth/mureed_signup_screen.dart';
import 'package:myapp/screens/auth/murshid_signup_screen.dart';
import 'package:myapp/screens/auth/waiting_for_approval_screen.dart';
import 'package:myapp/screens/mureed/mureed_dashboard_screen.dart';
import 'package:myapp/screens/murshid/murshid_dashboard_screen.dart';
import 'package:myapp/screens/super_admin/super_admin_dashboard_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/screens/super_admin/silsilah_management_screen.dart';
import 'package:myapp/screens/super_admin/silsilah_users_screen.dart';
import 'package:myapp/screens/super_admin/silsilah_tree_screen.dart';

class AppRouter {
  final AuthProvider authProvider;
  late final GoRouter router;

  AppRouter(this.authProvider) {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/murshid_signup',
          builder: (context, state) => const MurshidSignupScreen(),
        ),
        GoRoute(
          path: '/mureed_signup',
          builder: (context, state) => const MureedSignupScreen(),
        ),
        GoRoute(
          path: '/waiting_for_approval',
          builder: (context, state) => const WaitingForApprovalScreen(),
        ),
        GoRoute(
          path: '/super_admin_dashboard',
          builder: (context, state) => const SuperAdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin_dashboard',
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/murshid_dashboard',
          builder: (context, state) => const MurshidDashboardScreen(),
        ),
        GoRoute(
          path: '/mureed_dashboard',
          builder: (context, state) => const MureedDashboardScreen(),
        ),
        GoRoute(
          path: '/silsilah-management',
          builder: (context, state) => const SilsilahManagementScreen(),
        ),
        GoRoute(
          path: '/silsilah-users/:silsilahId',
          builder: (context, state) => SilsilahUsersScreen(
            silsilahId: state.pathParameters['silsilahId']!,
          ),
        ),
        GoRoute(
          path: '/silsilah-tree',
          builder: (context, state) => const SilsilahTreeScreen(),
        ),
      ],
      redirect: (context, state) {
        final user = authProvider.user;
        final isLoggedIn = user != null;
        final isApproved = authProvider.isApproved;

        final loggingIn = state.matchedLocation == '/login' ||
            state.matchedLocation == '/murshid_signup' ||
            state.matchedLocation == '/mureed_signup';

        if (!isLoggedIn && !loggingIn) {
          return '/login';
        }

        if (isLoggedIn && loggingIn) {
          if (!isApproved) {
            return '/waiting_for_approval';
          }
          switch (user.role) {
            case UserRole.superAdmin:
              return '/super_admin_dashboard';
            case UserRole.admin:
              return '/admin_dashboard';
            case UserRole.murshid:
              return '/murshid_dashboard';
            case UserRole.mureed:
              return '/mureed_dashboard';
          }
        }
        return null;
      },
      refreshListenable: authProvider,
    );
  }
}
