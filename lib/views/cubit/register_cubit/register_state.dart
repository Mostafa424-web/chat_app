abstract class RegisterStates {}
class RegisterInitial extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}
class RegisterLoading extends RegisterStates {}
class RegisterFailure extends RegisterStates {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}