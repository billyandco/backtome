import 'package:equatable/equatable.dart';

import 'package:backtome/providers/hive/hive.dart' as h;

class Parameter extends Equatable {
  const Parameter({
    required this.ip,
    required this.username,
    required this.password,
    required this.directory,
  });

  final String ip;
  final String username;
  final String password;
  final String directory;

  static const empty = Parameter(
    ip: '',
    username: '',
    password: '',
    directory: '',
  );

  h.Settings toHive() => h.Settings(
        ip: ip,
        username: username,
        password: password,
        directory: directory,
      );

  @override
  List<Object?> get props => [ip, username, password, directory];
}
