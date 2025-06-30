import 'package:fpdart/fpdart.dart';
import 'package:policy_vault_admin/network/response_model.dart';

abstract interface class AuthRepo {
  Future<Either<String, ResponseModel>> login({
    required String email,
    required String password,
  });
}
