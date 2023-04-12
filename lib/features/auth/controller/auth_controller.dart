import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/providers/firebase_provider.dart';
import 'package:reddit/features/auth/repository/auth_rerository.dart';

//provider
final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.read(AuthRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;
  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }
}
