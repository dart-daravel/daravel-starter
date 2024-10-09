import 'package:shelf/shelf.dart';

import '../../../resources/views/welcome.html.dart';
import 'controller.dart';

class LandingController extends Controller {
  Response api(Request req) {
    return Response.ok('Hello, World!\n');
  }

  Response web(Request req) {
    return Response.ok(
      welcome(),
      headers: {'Content-Type': 'text/html'},
    );
  }
}
