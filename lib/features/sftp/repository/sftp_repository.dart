import 'dart:io';

import 'package:backtome/providers/hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:ssh/ssh.dart';

import 'package:backtome/features/sftp/sftp.dart';

class SFTPRepository {
  const SFTPRepository();

  Future<bool> tryConnection([Parameter parameter = Parameter.empty]) async {
    Parameter params = parameter;
    if (params == Parameter.empty) {
      final settings = Hive.box<Settings>(LocalHiveBox.settings).get(LocalHiveKey.settings);

      if (settings == null) return false;
      params = Parameter(
        ip: settings.ip!,
        username: settings.username!,
        password: settings.password!,
        directory: settings.directory!,
      );
    }

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

      if (ls != null) {
        return true;
      }

      return false;
    } catch (e) {
      rethrow;
    } finally {
      client.disconnect();
    }
  }

  static Future<void> uploadTest() async {
    final settings = Hive.box<Settings>(LocalHiveBox.settings).get(LocalHiveKey.settings);

    final client = SSHClient(
      host: settings!.ip!,
      port: 22,
      username: settings.username!,
      passwordOrKey: settings.password,
    );

    try {
      await client.connect();
      await client.connectSFTP();

      for (final path in settings.directories) {
        final Directory dir = Directory(path);
        final files = dir.listSync().where((e) => e.statSync().type == FileSystemEntityType.file).toList();

        for (final file in files) {
          final res = await client.sftpUpload(
            path: file.path,
            toPath: settings.directory!,
          );
          print("${file.path} = $res");
        }
      }
    } catch (e) {
      rethrow;
    } finally {
      client.disconnect();
    }
  }
}
