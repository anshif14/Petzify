import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/auth/repository/auth_repository.dart';
import 'package:luna_demo/model/user_Model.dart';

final authControllerProvider = Provider((ref) => AuthController(AuthenticationRepository: ref.watch(authRepositoryProvider)));

class AuthController{
  final AuthenticationRepository _authenticationRepository;

  AuthController({required AuthenticationRepository}):
_authenticationRepository =AuthenticationRepository;

  addingUser(userModel usermodel){
    _authenticationRepository.addUser(usermodel);
  }

  // googleFunction(context){
  //   _authenticationRepository.signInWithGoogle(context);
  // }


}