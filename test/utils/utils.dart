import 'package:mockito/annotations.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import 'utils.mocks.dart';

@GenerateMocks([HttpResponse])
class ResponseUtils<T> {
  HttpResponse<T> getSuccssResponse(T data) {
    HttpResponse<T> response = HttpResponse<T>(
        data,
        Response<dynamic>(
            requestOptions: RequestOptions(path: ''), statusCode: 200));

    return response;
  }

  HttpResponse<T> getFailedResponse(T data) {
    return MockHttpResponse();
  }
}
