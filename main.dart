import 'dart:isolate';

import 'bootstrap/app.dart';

void main(List<String> args, SendPort? sendPort) async {
  boot(args, sendPort);
}
