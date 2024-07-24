import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/model/user_model.dart';
import 'package:instagram_clone/core/use_case/use_case.dart';
import 'package:instagram_clone/feature/app/domain/repository/current_user_repository.dart';

class GetCurrentUserData
    implements UseCase<UserModel, Map<String, String>, NoParams> {
  final CurrentUserRepository _currentUserRepository;

  GetCurrentUserData({required CurrentUserRepository currentUserRepository})
      : _currentUserRepository = currentUserRepository;

  @override
  Future<Either<Map<String, String>, UserModel>> call(NoParams params) async {
    return await _currentUserRepository.getCurrentUserData();
  }
}

final class NoParams {}
