import 'dart:io';

import 'package:flutter/foundation.dart';

import 'error/failures.dart';

String get baseUrl {
  if (kIsWeb) {
    return "https://localhost:7253/api";
  } else if (Platform.isAndroid) {
    return "https://10.0.2.2:7253/api";
  } else if (Platform.isIOS) {
    return "https://localhost:7253/api";
  } else {
    return "https://localhost:7253/api";
  }
}

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
