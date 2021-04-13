import 'package:equatable/equatable.dart';

import 'package:backtome/providers/hive/hive.dart' as h;

class Settings extends Equatable {
  const Settings({
    this.ip = '',
    this.port = 22,
    this.username = '',
    this.password = '',
    this.directory = '',
    this.directories = const [],
  });

  Settings.fromHive(h.Settings settings)
      : ip = settings.ip ?? '',
        port = settings.port,
        username = settings.username ?? '',
        password = settings.password ?? '',
        directory = settings.directory ?? '',
        directories = settings.directories;

  final String ip;
  final int port;
  final String username;
  final String password;
  final String directory;
  final List<String> directories;

  static const empty = Settings();

  Settings copyWith({
    String? ip,
    int? port,
    String? username,
    String? password,
    String? directory,
    List<String>? directories,
  }) =>
      Settings(
        ip: ip ?? this.ip,
        port: port ?? this.port,
        username: username ?? this.username,
        password: password ?? this.password,
        directory: directory ?? this.directory,
        directories: directories ?? this.directories,
      );

  @override
  List<Object?> get props => [
        ip,
        port,
        username,
        password,
        directory,
        directories,
      ];
}
