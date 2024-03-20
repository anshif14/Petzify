import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) => AuthController(AuthenticationRepository: ref.watch(authRepositoryProvider)));

class AuthController{
  final AuthenticationRepository _authenticationRepository;

  AuthController({required AuthenticationRepository}):
_authenticationRepository =AuthenticationRepository;

  googleFunction(context){
    _authenticationRepository.signInWithGoogle(context);
  }
}