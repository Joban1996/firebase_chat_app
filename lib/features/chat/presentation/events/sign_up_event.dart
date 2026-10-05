abstract class SignUpEvent {}

class SignUpHit extends SignUpEvent{
  final String email;
  final String password;
  SignUpHit(this.email,this.password);
}