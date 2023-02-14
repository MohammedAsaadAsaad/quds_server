part of quds_server;

class _ExitCommand extends CliCommand {
  @override
  Future<void> execute(ArgResults args) async {
    exit(0);
  }

  @override
  String get prefix => 'exit';
}
