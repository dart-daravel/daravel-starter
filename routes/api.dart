import 'package:daravel_core/daravel_core.dart';

import '../app/http/controllers/landing_controller.dart';

final apiRouter = DaravelRouter();

void apiRoutes() {
  apiRouter.get('/v1', LandingController().api);
}
