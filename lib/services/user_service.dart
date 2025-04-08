import 'package:sqlite_crud_operation/db_helper/repository.dart';
import 'package:sqlite_crud_operation/model/user.dart';

// Service layer is optional but improves project structure by separating logic.
class UserService {
  late Repository _repository;

  UserService() {
    _repository = Repository();
  }

  // Save User
  saveUser(User user) async {
    return await _repository.insertData("users", user.userMap());
  }

  // Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  // Update User
  updateUser(User user) async{
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async{
    return await _repository.deleteDataById('users', userId);
  }
}