class EmptyCacheExp implements Exception {}

class OfflineExp implements Exception {}

class ServerExp implements Exception {
  final String? message;

  const ServerExp({this.message});

  @override
  String toString() => message ?? 'Server Error';
}

class TokenNotFoundExp implements Exception {}
