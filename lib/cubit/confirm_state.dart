part of 'confirm_cubit.dart';

abstract class ConfirmState extends Equatable {
  const ConfirmState();
}

class ConfirmInitial extends ConfirmState {
  @override
  List<Object> get props => [];
}

class ConfirmLoading extends ConfirmState {
  @override
  List<Object> get props => [];
}

class ConfirmPass extends ConfirmState {
  final ConfirmResult confirmResult;

  ConfirmPass(this.confirmResult);

  @override
  List<Object> get props => [confirmResult];
}

class ConfirmFail extends ConfirmState {
  @override
  List<Object> get props => [];
}
