import 'dart:io';

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
      await _sftpRepository.tryConnection(Parameter(
        ip: ip,
        username: username,
        password: password,
        directory: path,
      ));
      emit(TrySFTPState.success);
    } catch (e) {
      print(e);
      emit(TrySFTPFailed(e.toString()));
    }
  }
}
