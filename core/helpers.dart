import 'package:daravel_core/daravel_core.dart';
import '../bootstrap/app.dart';

Core app() => core;

String? env(String key) => core.env(key);
