import 'package:backtome/features/directory/cubit/update_directories_cubit.dart';
import 'package:backtome/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectoriesView extends StatelessWidget {
  const DirectoriesView({Key? key}) : super(key: key);

  static MaterialPage page() => const MaterialPage<void>(child: DirectoriesView());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateDirectoriesCubit(),
      child: const _DirectoriesView(),
    );
  }
}

class _DirectoriesView extends StatefulWidget {
  const _DirectoriesView({Key? key}) : super(key: key);

  @override
  _DirectoriesViewState createState() => _DirectoriesViewState();
}

class _DirectoriesViewState extends State<_DirectoriesView> {
  List<String> backup = [];

  @override
  void initState() {
    super.initState();
    backup = [...BlocProvider.of<SettingsCubit>(context).state.directories];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: Navigator.of(context).pop,
        ),
        title: const Text('Foldertories'),
      ),
      body: BlocBuilder<UpdateDirectoriesCubit, UpdateDirectoriesState>(
        builder: (context, state) {
          if (state == UpdateDirectoriesState.empty) {
            return const Center(child: CircularProgressIndicator());
          }

          const have = Icon(Icons.favorite_rounded, color: Colors.redAccent);
          const doesntHave = Icon(Icons.favorite_outline_outlined, color: Colors.grey);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.phone.length,
                  itemBuilder: (context, index) {
                    final path = state.phone[index];
                    final haveIt = backup.contains(path);

                    return ListTile(
                      title: Text(path.split("/").last),
                      trailing: haveIt ? have : doesntHave,
                      onTap: () {
                        setState(() {
                          if (backup.contains(path)) {
                            backup.remove(path);
                          } else {
                            backup.add(path);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Floppy disk'),
                onPressed: () {
                  BlocProvider.of<SettingsCubit>(context).saveDirectories(backup);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
