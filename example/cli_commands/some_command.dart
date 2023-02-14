import 'dart:io';

import 'package:args/src/arg_results.dart';
import 'package:quds_server/quds_server.dart';

class SomeCommand extends CliCommand {
  @override
  String get prefix => 'some';

  @override
  Future<void> execute(ArgResults args) async {
    stdout.writeln('view some output');
  }
}
