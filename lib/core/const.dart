import 'error/failures.dart';

String baseUrl = "http://95.217.214.99/api";
// String baseUrl = "http://192.168.156.194:5000/api";
// String baseUrl = "http://192.168.1.5:5000/api";

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
