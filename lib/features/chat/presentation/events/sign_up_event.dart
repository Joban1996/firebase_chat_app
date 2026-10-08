abstract class SignUpEvent {}

class SignUpHit extends SignUpEvent{
  final String email;
  final String password;
  final String name;
  SignUpHit(this.email,this.password, this.name);
}