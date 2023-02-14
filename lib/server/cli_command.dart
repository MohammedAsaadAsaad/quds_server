part of quds_server;

abstract class CliCommand {
  String get prefix;
  Future<void> execute(ArgResults args);
}
