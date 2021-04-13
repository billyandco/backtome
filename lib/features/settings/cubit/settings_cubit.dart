import 'package:bloc/bloc.dart';

import 'package:backtome/features/sftp/sftp.dart';
import 'package:backtome/features/settings/settings.dart';

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit({
    required SettingsRepository settingsRepository,
  })   : _settingsRepository = settingsRepository,
        super(Settings.empty) {
    loadSettings();
  }

  final SettingsRepository _settingsRepository;

  Future<void> loadSettings() async {
    final settings = await _settingsRepository.load();
    emit(settings);
  }

  Future<void> saveSFTP(Parameter params) async {
    final settings = await _settingsRepository.saveSFTP(params);
    emit(settings);
  }

  Future<void> saveDirectories(List<String> directories) async {
    final settings = await _settingsRepository.saveDirectories(directories);
    emit(settings);
  }
}
