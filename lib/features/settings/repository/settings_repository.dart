import 'package:hive/hive.dart';

import 'package:backtome/features/settings/settings.dart';
import 'package:backtome/features/sftp/sftp.dart';
import 'package:backtome/providers/hive/hive.dart' as h;

class SettingsRepository {
  const SettingsRepository();

  static const String _box = h.LocalHiveBox.settings;
  static const String _key = h.LocalHiveKey.settings;

  Future<Settings> load() async {
    final hSettings = Hive.box<h.Settings>(_box).get(_key) ?? h.Settings();
    return Settings.fromHive(hSettings);
  }

  Future<Settings> saveSFTP(Parameter params) async {
    final hSettings = Hive.box<h.Settings>(_box).get(_key) ?? h.Settings();
    final h.Settings newHSettings = hSettings.copyWith(
      ip: params.ip,
      username: params.username,
      password: params.password,
      directory: params.directory,
    );
    await Hive.box<h.Settings>(_box).put(_key, newHSettings);
    return Settings.fromHive(newHSettings);
  }

  Future<Settings> saveDirectories(List<String> directories) async {
    final hSettings = Hive.box<h.Settings>(_box).get(_key) ?? h.Settings();
    final h.Settings newHSettings = hSettings.copyWith(directories: directories);
    await Hive.box<h.Settings>(_box).put(_key, newHSettings);
    return Settings.fromHive(newHSettings);
  }
}
