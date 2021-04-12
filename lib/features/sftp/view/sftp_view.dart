import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:backtome/helpers/helpers.dart';
import 'package:backtome/features/sftp/repository/repository.dart';
import 'package:backtome/features/sftp/sftp.dart';
import 'package:backtome/resources/resources.dart';

class SFTPView extends StatelessWidget {
  const SFTPView({Key? key}) : super(key: key);

  static MaterialPage page() => const MaterialPage<void>(child: SFTPView());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrySFTPCubit>(
      create: (context) => TrySFTPCubit(
        sftpRepository: context.read<SFTPRepository>(),
      ),
      child: const _SFTPView(),
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
    final params = BlocProvider.of<SFTPSettingsCubit>(context).state;
    tfIp.text = params.ip;
    tfUsername.text = params.username;
    tfPassword.text = params.password;
    tfPath.text = params.directory;
  }

  void onDone(BuildContext context) {
    closeKeyboard(context);
    BlocProvider.of<TrySFTPCubit>(context).tryConnection(
      tfIp.text.trim(),
      tfUsername.text.trim(),
      tfPassword.text.trim(),
      tfPath.text.trim(),
    );
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
      floatingActionButton: TrySFTPFloatingButton(
        onTap: onDone,
      ),
      body: SafeArea(
        child: BlocListener<TrySFTPCubit, TrySFTPState>(
          listener: (context, state) {
            print(state.runtimeType);
            if (state is TrySFTPSuccess) {
              BlocProvider.of<SFTPSettingsCubit>(context).save(state.parameter);
              print('Success !');
            } else if (state is TrySFTPFailed) {
              print('Failed : ${state.message}');
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
                  hintText: 'You shall "mot de passe" !!!',
                ),
              ),
              const SizedBox(height: BMSizes.large),
              TextField(
                controller: tfPath,
                decoration: const InputDecoration(
                  labelText: 'Backup directory',
                  hintText: 'I will "file" you',
                ),
                onSubmitted: (_) => onDone(context),
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

class TrySFTPFloatingButton extends StatelessWidget {
  const TrySFTPFloatingButton({Key? key, required this.onTap}) : super(key: key);

  final void Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    const loadingWidget = SizedBox(
      width: BMSizes.large,
      height: BMSizes.large,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );

    return BlocBuilder<TrySFTPCubit, TrySFTPState>(
      builder: (context, state) {
        final isLoading = state is TrySFTPPending;

        Color? color;
        Text text = const Text("Let's run it !");
        Icon icon = const Icon(Icons.run_circle);

        if (state is TrySFTPSuccess) {
          color = Colors.green;
          text = const Text("Success !");
          icon = const Icon(Icons.check);
        } else if (state is TrySFTPFailed) {
          color = Colors.redAccent;
          text = const Text("What's wrong ?");
          icon = const Icon(Icons.healing_outlined);
        }

        return FloatingActionButton.extended(
          icon: isLoading ? loadingWidget : icon,
          label: text,
          isExtended: !isLoading,
          backgroundColor: color,
          onPressed: () {
            if (!isLoading) {
              onTap(context);
            }
          },
        );
      },
    );
  }
}
