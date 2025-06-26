import 'package:flutter/material.dart';
import 'package:policy_vault_admin/features/side_menu/provider/side_menu_provider.dart';
import 'package:policy_vault_admin/injection_container.dart' as di;
import 'package:policy_vault_admin/router/router.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Routes>(
          lazy: false,
          create: (BuildContext context) => Routes(
            sessionManager: di.serviceLocator(),
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => AuthProvider(
        //     authRepo: di.serviceLocator(),
        //     sessionManager: di.serviceLocator(),
        //   ),
        // ),
        ChangeNotifierProvider(create: (context) => SideMenuProvider()),
      ],
      child: child,
    );
  }
}
