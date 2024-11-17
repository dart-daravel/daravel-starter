import 'dart:isolate';

import 'package:args/command_runner.dart';

import 'package:daravel_core/daravel_core.dart';

import '../routes/api.dart';

import 'config.dart';
import 'models.dart';

late final Core core;

Future<void> boot(List<String> args, SendPort? sendPort) async {
  core = Core(
    configMap: config,
    routers: [
      apiRouter,
    ],
    globalMiddlewares: [
      LoggerMiddleware(),
    ],
    models: models,
    boot: (core) {
      bootConfig();
      bootModels();
      DB.boot(core);
      apiRoutes();
    },
    onBootError: (error) {
      if (sendPort != null) {
        sendPort.send(-1);
      }
      return false;
    },
  );

  final commandRunner = CommandRunner("dartisan", "The CLI tool for Daravel")
    ..addCommand(ServeCommand(core));

  if (commandRunner.parse(args).command == null) {
    if (sendPort == null) {
      commandRunner.printUsage();
    }
    sendPort?.send(null);
    return;
  }

  commandRunner.run(args);
}
