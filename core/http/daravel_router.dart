import 'package:shelf_router/shelf_router.dart';

class DaravelRoute {
  final String method;
  final String path;
  final Function? handler;
  final List<DaravelRoute> routes;

  DaravelRoute(
    this.method,
    this.path,
    this.handler, {
    this.routes = const [],
  });
}

class DaravelRouter {
  DaravelRouter();

  final List<DaravelRoute> _routes = [];

  void get(String path, Function handler) {
    _routes.add(DaravelRoute('GET', path, handler));
  }

  void post(String path, Function handler) {
    _routes.add(DaravelRoute('POST', path, handler));
  }

  void put(String path, Function handler) {
    _routes.add(DaravelRoute('PUT', path, handler));
  }

  void delete(String path, Function handler) {
    _routes.add(DaravelRoute('DELETE', path, handler));
  }

  void group(String path, Function(DaravelRouter) callback) {
    final router = DaravelRouter();
    callback(router);

    _routes.add(DaravelRoute('', path, null, routes: router.routes));
  }

  List<DaravelRoute> get routes => _routes;

  Router get router {
    final router = Router();

    for (final route in _routes) {
      if (route.routes.isEmpty) {
        router.add(route.method, route.path, (req) {
          return route.handler!(req);
        });
      } else {
        final nestedRouter = DaravelRouter();
        nestedRouter._routes.addAll(route.routes);
        router.mount(route.path, nestedRouter.router.call);
      }
    }

    return router;
  }
}
