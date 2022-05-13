part of quds_server;

enum ServerStatusCodeGroup {
  informationalResponse._(1),
  successfullResponse._(2),
  redirectionMessage._(3),
  clientErrorResponse._(4),
  serverErrorResponse._(5);

  final int prefix;
  const ServerStatusCodeGroup._(this.prefix);

  factory ServerStatusCodeGroup(int prefix) =>
      ServerStatusCodeGroup.values.firstWhere((e) => e.prefix == prefix);
}
