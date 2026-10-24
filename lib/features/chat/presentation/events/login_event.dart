
abstract class LoginEvent {}

class LoginHit extends LoginEvent {
  final String email;
  final String password;

  LoginHit({
    required this.email,
    required this.password,
  });
}
