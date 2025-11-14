part of 'advisor_cubit.dart';

sealed class AdvisorCubitState extends Equatable {
  const AdvisorCubitState();

  @override
  List<Object?> get props => [];
}

final class AdvisorInitial extends AdvisorCubitState {}

final class AdvisorLoadingState extends AdvisorCubitState {}

//here we need props to campare objects because here attribute is present
final class AdvisorLoadedState extends AdvisorCubitState {
  final String advice;

  const AdvisorLoadedState({required this.advice});

  @override
  List<Object?> get props => [advice];
}

final class AdvisorErrorState extends AdvisorCubitState {
  final String errorMsg;

  const AdvisorErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
