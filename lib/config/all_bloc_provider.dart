import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:official_chatbox_admin_application/features/data/data_sources/users_data/users_data.dart';
import 'package:official_chatbox_admin_application/features/data/repositories/user_repo_impl.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/user/user_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:official_chatbox_admin_application/features/presentation/bloc/navigation/navigation_bloc.dart';

final FirebaseFirestore fireStore = FirebaseFirestore.instance;
final FirebaseStorage fireStorage = FirebaseStorage.instance;

class AllBlocProvider {
  static List<SingleChildWidget> allBlocProviders = [
    BlocProvider(
      create: (context) => NavigationBloc(),
    ),
    BlocProvider(
      create: (context) => UserBloc(
        userRepository: UserRepoImpl(
          usersData: UsersData(
            firebaseFirestore: fireStore,
          ),
        ),
      )..add(GetAllUsersEvent()),
    ),
  ];
}
