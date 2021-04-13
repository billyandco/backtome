import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_directories_state.dart';

class UpdateDirectoriesCubit extends Cubit<UpdateDirectoriesState> {
  UpdateDirectoriesCubit() : super(const UpdateDirectoriesState()) {
    load();
  }

  static const _userRoot = "/storage/emulated/0";

  bool filter(FileSystemEntity f) {
    final filterRegex = RegExp(r"\/((Android)|(\..*))$");
    return f.statSync().type == FileSystemEntityType.directory && !filterRegex.hasMatch(f.path);
  }

  Future<void> load() async {
    final Directory directory = Directory(_userRoot);
    final lsUserRoot = directory.listSync();

    final phone = lsUserRoot
        .where(filter)
        .map((e) => Directory(e.path).listSync(recursive: true)..add(e))
        .expand((e) => e)
        .where(filter)
        .map((e) => e.path)
        .toList()
          ..sort();

    emit(state.copyWith(
      phone: phone,
    ));
  }
}
