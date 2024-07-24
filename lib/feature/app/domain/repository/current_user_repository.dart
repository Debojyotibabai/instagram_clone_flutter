import 'package:fpdart/fpdart.dart';
import 'package:instagram_clone/core/model/user_model.dart';

abstract interface class CurrentUserRepository {
  Future<Either<Map<String, String>, UserModel>> getCurrentUserData();
}
