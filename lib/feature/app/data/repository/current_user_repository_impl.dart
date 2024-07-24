import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/model/user_model.dart';
import 'package:instagram_clone/feature/app/data/data_source/current_user_data_source.dart';
import 'package:instagram_clone/feature/app/domain/repository/current_user_repository.dart';

class CurrentUserRepositoryImpl implements CurrentUserRepository {
  final CurrentUserDataSource _currentUserDataSource;

  CurrentUserRepositoryImpl(
      {required CurrentUserDataSource currentUserDataSource})
      : _currentUserDataSource = currentUserDataSource;

  @override
  Future<Either<Map<String, String>, UserModel>> getCurrentUserData() async {
    try {
      final response = await _currentUserDataSource.getCurrentUserData();

      return Right(response);
    } catch (err) {
      return Left(err as Map<String, String>);
    }
  }
}
