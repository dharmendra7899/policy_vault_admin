import 'package:flutter/material.dart';
import 'package:policy_vault_admin/router/router.dart';
import 'package:policy_vault_admin/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

    final appRouter = Provider.of<Routes>(context, listen: false).router;
    return MaterialApp.router(
      routeInformationProvider: appRouter.routeInformationProvider,
      routeInformationParser: appRouter.routeInformationParser,
      routerDelegate: appRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      title: 'Policy Vault',
    );
  }
}
