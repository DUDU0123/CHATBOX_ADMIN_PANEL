import 'package:official_chatbox_admin_application/features/data/data_sources/users_data/users_data.dart';
import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';
import 'package:official_chatbox_admin_application/features/domain/repositories/user_repo/user_repository.dart';

class UserRepoImpl extends UserRepository {
  final UsersData usersData;
  UserRepoImpl({
    required this.usersData,
  });
  @override
  Stream<List<UserModel>>? getAllUsersInDB() {
    return usersData.getAllUsersInDB();
  }
  
  @override
  Stream<List<UserModel>>? getAllDisabeledUsersInDB() {
    return usersData.getAllDisabledUsersFromDB();
  }
  
  @override
  Stream<List<UserModel>>? getAllReportedAccountsInDB() {
    return usersData.getAllReportedAccountsFromDB();
  }
  
  @override
  Future<bool> disableUser({required String userId}) {
    return usersData.disableUser(userId: userId);
  }
  
  @override
  Future<bool> enableUser({required String userId}) {
    return usersData.enableUser(userId: userId);
  }

}
