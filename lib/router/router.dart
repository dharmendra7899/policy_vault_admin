import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/features/admin_management/view/add_admin_user_screen.dart';
import 'package:policy_vault_admin/features/admin_management/view/admin_management_screen.dart';
import 'package:policy_vault_admin/features/auth/view/login_screen.dart';
import 'package:policy_vault_admin/features/cms/view/about_us_screen.dart';
import 'package:policy_vault_admin/features/cms/view/add_claims.dart';
import 'package:policy_vault_admin/features/cms/view/add_company.dart';
import 'package:policy_vault_admin/features/cms/view/add_faqs.dart';
import 'package:policy_vault_admin/features/cms/view/claim_information_screen.dart';
import 'package:policy_vault_admin/features/cms/view/faqs_screen.dart';
import 'package:policy_vault_admin/features/cms/view/insurance_company_screen.dart';
import 'package:policy_vault_admin/features/dashboard/view/dashboard_screen.dart';
import 'package:policy_vault_admin/features/side_menu/view/admin_wrapper.dart';
import 'package:policy_vault_admin/features/support_management/view/support_management_screen.dart';
import 'package:policy_vault_admin/features/user_management/view/all_users.dart';
import 'package:policy_vault_admin/features/user_management/view/view_user_details.dart';
import 'package:policy_vault_admin/helper/session_manager.dart';
import 'package:policy_vault_admin/res/widgets/context_extension.dart';

class Routes {
  final SessionManager sessionManager;

  Routes({required this.sessionManager});

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,

    // Displayed on unmatched routes
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: SelectableText(
            'Page not found',
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },

    // Route definitions
    routes: [
      GoRoute(
        path: '/login',
        name: 'Login',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, _, child) => SlideTransition(
            position: animation.drive(
              Tween(begin: Offset.zero, end: Offset.zero),
            ),
            child: child,
          ),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => AdminWrapper(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            name: 'Dashboard',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: DashboardScreen(),
              transitionsBuilder: (context, animation, _, child) =>
                  SlideTransition(
                    position: animation.drive(
                      Tween(begin: Offset.zero, end: Offset.zero),
                    ),
                    child: child,
                  ),
            ),
          ),
          GoRoute(
            path: '/users-management',
            name: 'Users Management',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AllUsers(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/support-management',
            name: 'Support Management',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const SupportManagementScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/manage-admin',
            name: 'Manage Admin User',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AdminManagementScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/about-us',
            name: 'About Us',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AboutUsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/faqs',
            name: 'FAQs',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const FaqsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/claim-information',
            name: 'Claim Information',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const ClaimInformationScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/insurance-company',
            name: 'Insurance Company',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const InsuranceCompanyScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/add-admin',
            name: 'Add Admin User',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AddAdminUserScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/user-details',
            name: 'User Details',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const ViewUserDetails(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/add-claim',
            name: 'Add Claim',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AddClaims(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/add-faq',
            name: 'Add FAQ',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AddFaqs(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween(begin: Offset.zero, end: Offset.zero),
                          ),
                          child: child,
                        ),
              );
            },
          ),
          GoRoute(
            path: '/add-company',
            name: 'Add Company',
            pageBuilder: (context, state) {
              return CustomTransitionPage<void>(
                key: state.pageKey,
                child: const AddCompany(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
                      position: animation.drive(
                        Tween(begin: Offset.zero, end: Offset.zero),
                      ),
                      child: child,
                    ),
              );
            },
          ),
        ],
      ),
    ],

    // Redirect logic
    redirect: (context, state) {
      final currentPath = state.fullPath ?? state.path ?? '';
      if (currentPath == '/' || currentPath.isEmpty) {
        return '/login';
      }
      return null;
    },
  );
}
