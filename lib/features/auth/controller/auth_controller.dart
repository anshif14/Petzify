import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/auth/repository/auth_repository.dart';
import 'package:luna_demo/model/user_Model.dart';

final authControllerProvider = Provider((ref) => AuthController(AuthenticationRepository: ref.watch(authRepositoryProvider)));

class AuthController{
  final AuthenticationRepository _authenticationRepository;

  AuthController({required AuthenticationRepository}):
_authenticationRepository =AuthenticationRepository;

  addingUser(UserModel usermodel){
    _authenticationRepository.addUser(usermodel);
  }

  userupd(UserModel usermodel){
    _authenticationRepository.userupdate(usermodel);
  }
/// edit(userModel  editModel){
///   _authenticationRepository..addingupdate(editModel);
/// }


// googleFunction(context){
  //   _authenticationRepository.signInWithGoogle(context);
  // }


}