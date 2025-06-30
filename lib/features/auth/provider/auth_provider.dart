import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:policy_vault_admin/features/auth/repository/auth_repo.dart';
import 'package:policy_vault_admin/helper/session_manager.dart';
import 'package:policy_vault_admin/network/response_model.dart';
import 'package:policy_vault_admin/utils.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final SessionManager sessionManager;

  AuthProvider({required this.authRepo, required this.sessionManager}) {
    sessionManager.getSession().then((value) {
      _userData = value;
    });
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  dynamic _userData;

  dynamic get userData => _userData;

  _setShowLoader(bool value) {
    _showLoader = value;
  }

  login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    try {
      var res = await authRepo.login(email: email, password: password);
      res.fold(
        (String message) {
          Utils.showToast(message: message, context: context);
        },
        (ResponseModel response) {
          //_userData = UserDataModel.fromJson(response.data);
          sessionManager.setToken(_userData.token ?? '');
          Utils.showToast(
            message: response.message ?? '',
            type: ToastType.success,
            context: context,
          );
          context.goNamed('Dashboard');
        },
      );
    } catch (e) {
      debugPrint("Verify OTP Exception: $e");
    } finally {
      _setShowLoader(false);
    }
  }

  validateNavigation(BuildContext context) {
    sessionManager.getToken().then((value) {
      debugPrint('Token :: $value');
      if (value.isEmpty) {
        if (context.mounted) {
          context.goNamed('Login');
        }
      } else {
        if (context.mounted) {
          context.goNamed('Dashboard');
        }
      }
    });
  }

  logout(BuildContext context) {
    sessionManager.clearSession();
    context.go('/login');
  }

  getUserData() {
    sessionManager.getSession().then((value) {
      _userData = value;
      notifyListeners();
    });
  }
}
