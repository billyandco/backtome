import 'package:backtome/features/sftp/sftp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backtome/features/sftp/repository/repository.dart';
import 'package:backtome/resources/resources.dart';

class SFTPView extends StatelessWidget {
  const SFTPView({Key? key}) : super(key: key);

  static MaterialPage page() => const MaterialPage<void>(child: SFTPView());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<SFTPRepository>(
      create: (_) => const SFTPRepository(),
      child: BlocProvider<TrySFTPCubit>(
        create: (context) => TrySFTPCubit(
          sftpRepository: context.read<SFTPRepository>(),
        ),
        child: const _SFTPView(),
      ),
    );
  }
}

class _SFTPView extends StatefulWidget {
  const _SFTPView({Key? key}) : super(key: key);

  @override
  _SFTPViewState createState() => _SFTPViewState();
}

class _SFTPViewState extends State<_SFTPView> {
  TextEditingController tfIp = TextEditingController();
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfPath = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO get from box
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
        title: const Text('Super Fine Tall Person'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.run_circle),
        label: const Text("Let's run it !"),
        onPressed: () {
          BlocProvider.of<TrySFTPCubit>(context).tryConnection(
            tfIp.text.trim(),
            tfUsername.text.trim(),
            tfPassword.text.trim(),
            tfPath.text.trim(),
          );
        },
      ),
      body: SafeArea(
        child: BlocListener<TrySFTPCubit, TrySFTPState>(
          listener: (context, state) {
            if (state is TrySFTPSuccess) {
              // TODO success message
            } else if (state is TrySFTPFailed) {
              // TODO failed message
            }
          },
          child: ListView(
            padding: const EdgeInsets.all(BMSizes.large),
            children: [
              TextField(
                controller: tfIp,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'IP address',
                  hintText: 'And text me maybe',
                ),
              ),
              const SizedBox(height: BMSizes.large),
              TextField(
                controller: tfUsername,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: "I'm Name, User Name",
                ),
              ),
              const SizedBox(height: BMSizes.large),
              TextField(
                controller: tfPassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'You shall "mot de passe"',
                ),
              ),
              const SizedBox(height: BMSizes.large),
              TextField(
                controller: tfPath,
                decoration: const InputDecoration(
                  labelText: 'Backup directory',
                  hintText: 'I will "file" you',
                ),
              ),
              const SizedBox(height: BMSizes.large),
              const Text(
                "Default port is 22. But ok, it will be editable later.\nAnd maybe it will be able to set private and public key, be kind.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
