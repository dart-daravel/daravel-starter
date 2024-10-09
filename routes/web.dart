import 'package:daravel_core/daravel_core.dart';

import '../app/http/controllers/landing_controller.dart';

final webRouter = DaravelRouter();

void apiRoutes() {
  webRouter.get('/', LandingController().web);
}
