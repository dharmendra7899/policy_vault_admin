import 'package:flutter/material.dart';
import 'package:policy_vault_admin/app.dart';
import 'package:policy_vault_admin/providers.dart';
import 'package:url_strategy/url_strategy.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  setPathUrlStrategy();
  runApp(const Providers(
    child: App(),
  ));
}