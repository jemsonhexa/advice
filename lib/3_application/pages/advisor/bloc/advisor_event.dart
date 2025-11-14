part of 'advisor_bloc.dart';

@immutable
sealed class AdvisorEvent {}

//event when user request for advice
class AdvisorRequestEvent extends AdvisorEvent {}
