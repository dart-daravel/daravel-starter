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

  void patch(String path, Function handler) {
    _routes.add(DaravelRoute('PATCH', path, handler));
  }

  void all(String path, Function handler) {
    _routes.add(DaravelRoute('', path, handler));
  }

  void options(String path, Function handler) {
    _routes.add(DaravelRoute('OPTIONS', path, handler));
  }

  void head(String path, Function handler) {
    _routes.add(DaravelRoute('HEAD', path, handler));
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

  /// Get router
  Router get router {
    final router = Router();
    _buildRoutes(_routes, router);
    return router;
  }

  /// Build routes
  void _buildRoutes(List<DaravelRoute> routes, Router router,
      {Router? parentRouter, String? groupPrefix}) {
    String lastGroupPrefix = '';

    for (final route in routes) {
      if (route.routes.isEmpty) {
        if (groupPrefix == null) {
          // Linear routes
          router.add(route.method, route.path, (req) {
            return route.handler!(req);
          });
        } else {
          // Grouped routes
          router.add(route.method, route.path, (req) {
            return route.handler!(req);
          });
          parentRouter?.mount("$groupPrefix$lastGroupPrefix", router.call);
        }
      } else {
        // Grouped routes - Recursive section
        lastGroupPrefix += route.path;
        final nestedRouter = Router();
        _buildRoutes(route.routes, nestedRouter,
            groupPrefix: lastGroupPrefix, parentRouter: router);
        lastGroupPrefix = lastGroupPrefix.replaceAll(route.path, '');
      }
    }
  }
}
