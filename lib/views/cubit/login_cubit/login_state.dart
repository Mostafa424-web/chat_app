abstract class LoginStates {}
class LoginInitial extends LoginStates {}

class LoginSuccess extends LoginStates {}
class LoginLoading extends LoginStates {}
class LoginFailure extends LoginStates {
   String errorMessage;
  LoginFailure({required this.errorMessage});
}