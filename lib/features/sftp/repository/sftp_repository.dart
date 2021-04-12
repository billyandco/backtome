import 'package:backtome/providers/hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:ssh/ssh.dart';

import 'package:backtome/features/sftp/sftp.dart';

class SFTPRepository {
  const SFTPRepository();

  Future<bool> tryConnection(Parameter params) async {
    final client = SSHClient(
      host: params.ip,
      port: 22,
      username: params.username,
      passwordOrKey: params.password,
    );

    try {
      await client.connect();
      await client.connectSFTP();

      final ls = await client.sftpLs(params.directory);

      if (ls == null || ls.isEmpty) return false;

      final box = LocalHiveBox.settings.toString();
      final key = LocalHiveKey.settings.toString();

      final hParams = Hive.box<Settings>(box).get(key) ?? Settings();
      final Settings newHParams = hParams.copyWith(
        ip: params.ip,
        username: params.username,
        password: params.password,
        directory: params.directory,
      );

      await Hive.box<Settings>(box).put(key, newHParams);
    } catch (e) {
      rethrow;
    } finally {
      await client.disconnectSFTP();
      client.disconnect();
    }

    return true;
  }
}
