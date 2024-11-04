import 'package:daravel_core/daravel_core.dart';

import '../core/helpers.dart';

@Config()
class Database {
  String defaultConnection = 'sqlite';

  Map<String, DatabaseConnection> connections = {
    'sqlite': DatabaseConnection(
      driver: 'sqlite',
      url: env<String>('DB_URL', 'database.sqlite'),
      database: 'database.sqlite',
      prefix: '',
      foreignKeyConstraints: env<bool>('DB_FOREIGN_KEYS', true),
    ),
  };
}
