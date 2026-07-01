import 'error/failures.dart';

String baseUrl = "http://46.224.105.68:8080/api";

//hi
String mapFailureToMessage(Failures failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "SERVER_FAILURE_MESSAGE";
    case EmptyCacheFailure:
      return "EMPTY_CACHE_FAILURE_MESSAGE";
    case OfflineFailure:
      return "OFFLINE_FAILURE_MESSAGE";
    default:
      return "Unexpected Error , Please try again later .";
  }
}
