/// Exception occur when server failure
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, this.statusCode);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.statusCode == statusCode;
    }

    return false;
  }
}

/// Exception occur when call api over on time
class CancelTokenException implements Exception {
  final String message;
  final int? statusCode;

  CancelTokenException(this.message, this.statusCode);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class FirebaseFirestoreException implements Exception {
  final String message;

  FirebaseFirestoreException(this.message);
}