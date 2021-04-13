import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:backtome/features/sftp/sftp.dart';

part 'try_sftp_state.dart';

class TrySFTPCubit extends Cubit<TrySFTPState> {
  TrySFTPCubit({
    required SFTPRepository sftpRepository,
  })   : _sftpRepository = sftpRepository,
        super(TrySFTPState.initial);

  final SFTPRepository _sftpRepository;

  Future<void> tryConnection(String ip, String username, String password, String path) async {
    try {
      emit(TrySFTPState.pending);

      final params = Parameter(
        ip: ip,
        username: username,
        password: password,
        directory: path,
      );

      final bool success = await _sftpRepository.tryConnection(params);

      if (success) {
        emit(TrySFTPSuccess(params));
      } else {
        emit(const TrySFTPFailed('failed'));
      }
    } catch (e) {
      emit(TrySFTPFailed(e.toString()));
    }
  }
}
