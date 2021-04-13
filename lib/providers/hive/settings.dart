import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class Settings extends HiveObject {
  Settings({
    this.ip,
    this.port = 22,
    this.username,
    this.password,
    this.directory,
    this.directories = const [],
  });

  @HiveField(0)
  final String? ip;
  @HiveField(1)
  final int port;
  @HiveField(2)
  final String? username;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final String? directory;
  @HiveField(5)
  final List<String> directories;

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
}
