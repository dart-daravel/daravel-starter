import 'package:daravel_core/daravel_core.dart';
import '../routes/api.dart';

void boot() async {
  apiRoutes();

  final app = DaravelApp(
    routers: [
      apiRouter,
    ],
    globalMiddlewares: [
      LoggerMiddleware(),
    ],
  );

  await app.run();
}
