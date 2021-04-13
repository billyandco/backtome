part of 'update_directories_cubit.dart';

class UpdateDirectoriesState extends Equatable {
  const UpdateDirectoriesState({
    this.phone = const [],
  });

  final List<String> phone;

  static const empty = UpdateDirectoriesState();

  UpdateDirectoriesState copyWith({
    List<String>? phone,
  }) =>
      UpdateDirectoriesState(
        phone: phone ?? this.phone,
      );

  @override
  List<Object> get props => [phone];
}
