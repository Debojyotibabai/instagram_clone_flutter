import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/use_case/use_case.dart';
import 'package:instagram_clone/feature/auth/domain/repository/auth_repository.dart';

class UserLogin
    implements
        UseCase<Map<String, String>, Map<String, String>, UserLoginParams> {
  UserLogin({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<Either<Map<String, String>, Map<String, String>>> call(
    UserLoginParams params,
  ) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

final class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
