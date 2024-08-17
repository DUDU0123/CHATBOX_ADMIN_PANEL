import 'package:official_chatbox_admin_application/features/data/models/user_model/user_model.dart';

abstract class UserRepository {
  Stream<List<UserModel>>? getAllUsersInDB();
  Stream<List<UserModel>>? getAllDisabeledUsersInDB();
  Stream<List<UserModel>>? getAllReportedAccountsInDB();
}
