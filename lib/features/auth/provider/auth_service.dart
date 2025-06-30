import 'package:fpdart/fpdart.dart';
import 'package:policy_vault_admin/features/auth/repository/auth_repo.dart';
import 'package:policy_vault_admin/network/api_client.dart';
import 'package:policy_vault_admin/network/response_model.dart';
import 'package:policy_vault_admin/network/server_error.dart';
import 'package:policy_vault_admin/res/constants/app_urls.dart';

class AuthService implements AuthRepo {
  final ApiClient apiClient;

  AuthService({required this.apiClient});

  @override
  Future<Either<String, ResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var res = await apiClient.postApi(
        url: AppUrls.loginEndPoint,
        body: {'email': email, 'password': password},
      );

      return Right(res!);
    } on ServerError catch (e) {
      return Left(e.message ?? '');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
