import 'package:backtome/features/sftp/sftp.dart';
import 'package:bloc/bloc.dart';

class SFTPSettingsCubit extends Cubit<Parameter> {
  SFTPSettingsCubit({
    required SFTPRepository sftpRepository,
  })   : _sftpRepository = sftpRepository,
        super(Parameter.empty) {
    loadSFTPSettings();
  }

  final SFTPRepository _sftpRepository;

  void loadSFTPSettings() {
    final params = _sftpRepository.getSFTPFromHive();
    emit(params);
  }

  Future<void> save(Parameter params) async {
    await _sftpRepository.save(params);
    emit(params);
  }
}
