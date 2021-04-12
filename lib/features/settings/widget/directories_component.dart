import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DirectoriesComponent extends StatelessWidget {
  const DirectoriesComponent();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future<List<String>>(() async {
        final appFiles = (await getExternalStorageDirectory())!.path;
        final cut = appFiles.indexOf("/Android");
        final goodDir = appFiles.substring(0, cut);
        print(goodDir);

        File f = File("$goodDir/Hello/image.png");
        print(f.path);
        print(f.lastModified());

        return [
          appFiles,
          goodDir,
          // (await getExternalStorageDirectory())!.path,
          // (await getApplicationDocumentsDirectory()).path,
          // (await getApplicationSupportDirectory()).path,
          // (await getExternalCacheDirectories()).toString(),
          // (await getExternalStorageDirectories()).toString(),
          // (await getTemporaryDirectory()).path,
        ];
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final dir = snapshot.data! as List<String>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: dir.map((e) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(e))).toList(),
          );
        }

        return const SizedBox();
      },
    );
  }
}
