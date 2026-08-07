import 'error/failures.dart';

// String baseUrl = "http://46.224.105.68:8080/api";
// String baseUrl = "http://10.0.2.2:5000/api";
String baseUrl = "http://192.168.1.5:5000/api";

String mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      final serverFailure = failure as ServerFailure;
      return serverFailure.message ?? "SERVER_FAILURE_MESSAGE";
    case EmptyCacheFailure:
      return "EMPTY_CACHE_FAILURE_MESSAGE";
    case OfflineFailure:
      return "OFFLINE_FAILURE_MESSAGE";
    default:
      return "Unexpected Error , Please try again later .";
  }
}
