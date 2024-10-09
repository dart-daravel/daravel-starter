import 'dart:isolate';

import 'package:args/command_runner.dart';

import 'package:daravel_core/daravel_core.dart';

import '../routes/api.dart';

import 'config.dart';

late final Core core;

void boot(List<String> args, SendPort? sendPort) async {
  bootConfig();
  apiRoutes();

  core = Core(
    configMap: config,
    routers: [
      apiRouter,
    ],
    globalMiddlewares: [
      LoggerMiddleware(),
    ],
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
