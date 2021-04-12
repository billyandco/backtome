part of 'try_sftp_cubit.dart';

abstract class TrySFTPState extends Equatable {
  const TrySFTPState();

  static const initial = TrySFTPInitial();
  static const pending = TrySFTPPending();

  @override
  List<Object> get props => [];
}

class TrySFTPInitial extends TrySFTPState {
  const TrySFTPInitial();
}

class TrySFTPPending extends TrySFTPState {
  const TrySFTPPending();
}

class TrySFTPSuccess extends TrySFTPState {
  const TrySFTPSuccess(this.parameter);

  final Parameter parameter;
}

class TrySFTPFailed extends TrySFTPState {
  const TrySFTPFailed(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
