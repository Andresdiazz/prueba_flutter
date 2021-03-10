import '../model/user.dart';
import 'cloudFirestoreAPI.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) =>
      _cloudFirestoreAPI.updateUserData(user);
  void registerUserDataFirestore(User user) =>
      _cloudFirestoreAPI.registerUserData(user);
}
