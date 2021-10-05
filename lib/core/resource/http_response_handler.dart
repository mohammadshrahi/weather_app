import 'package:retrofit/dio.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class HttpResponseHandler<T> {
  Future<Resource> handle(Future<HttpResponse<T>> future) async {
    Resource resource;
    var response;
    try {
      response = await future;

      resource = SuccessResource<T>(response.data);
    } catch (error) {
      if (error.runtimeType == DioError &&
          (error as DioError).response != null) {
        final res = (error as DioError).response;

        resource = _handleResponse(res);
      } else if (error is TypeError) {
        resource =
            FailedResource(error, message: "Error in Parsing server response.");
      } else {
        resource = FailedResource(error, message: "Fail to connect");
      }
    }

    return resource;
  }

  FailedResource _handleResponse(Response? res) {
    FailedResource failedResource;
    switch (res?.statusCode) {
      case HttpStatus.notFound:
        {
          failedResource =
              FailedResource(HttpStatus.notFound, message: "Not found ");
          break;
        }
      case HttpStatus.internalServerError:
        {
          failedResource =
              FailedResource(HttpStatus.notFound, message: "Please try again ");
          break;
        }
      default:
        {
          failedResource = FailedResource(HttpStatus.internalServerError,
              message: "Something went wrong! please try again ");
        }
    }
    return failedResource;
  }
}
