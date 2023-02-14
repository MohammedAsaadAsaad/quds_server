part of quds_server;

class _HelpCommand extends CliCommand {
  final Map<String, CliCommand> otherCommands;

  _HelpCommand(this.otherCommands);

  @override
  Future<void> execute(ArgResults args) async {
    for (var c in otherCommands.entries) {
      print(c.value.prefix);
    }
  }

  @override
  String get prefix => 'help';
}
