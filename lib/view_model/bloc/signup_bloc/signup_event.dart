part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupRequested extends SignupEvent {
  final UserModel user;
  final BuildContext context;

  SignupRequested({
    required this.user,
    required this.context,
  });
}