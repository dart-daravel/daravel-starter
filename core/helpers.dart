import 'package:daravel_core/daravel_core.dart';
import '../bootstrap/app.dart';

Core app() => core;

T? env<T>(String key, [T? defaultValue]) => core.env<T>(key) ?? defaultValue;

Object? config<T>(String key, [dynamic defaultValue]) =>
    core.config(key) ?? defaultValue as T;
