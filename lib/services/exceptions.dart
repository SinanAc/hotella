class NetWorkException {
  final String message;

  NetWorkException({
    required this.message,
  });
}

class NoserviceException {
  final String message;

  NoserviceException({
    required this.message,
  });
}

class ConnectionTimeOutException {
  final String message;

  ConnectionTimeOutException({
    required this.message,
  });
}

class BadRequestException {
  final String message;

  BadRequestException({
    required this.message,
  });
}

class UnAuthirizedException {
  final String message;

  UnAuthirizedException({
    required this.message,
  });
}

class FetchDataException {
  final String message;

  FetchDataException({
    required this.message,
  });
}

class NoteFound {
  final String message;

  NoteFound({
    required this.message,
  });
}

class ErrorResponse {
      static dynamic processResponse(response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(message: 'Server Bad Request');
      case 401:
      case 403:
        throw UnAuthirizedException(message: 'Address Not Found');
      case 404:
        throw NoteFound(message: 'Url Not Found ');
      default:
        throw FetchDataException(
            message:
                'Error Occured while connecting to server With StatusCode :${response.statusCode}');
    }
  }
}
