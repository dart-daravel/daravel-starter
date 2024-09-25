import '../app/http/controllers/landing_controller.dart';
import '../core/http/daravel_router.dart';

final webRouter = DaravelRouter();

void apiRoutes() {
  webRouter.get('/', LandingController().web);
}
