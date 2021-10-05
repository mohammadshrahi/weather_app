// Mocks generated by Mockito 5.0.16 from annotations
// in weather_app/test/utils/utils.dart.
// Do not manually edit this file.

import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:retrofit/dio.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0<T> extends _i1.Fake implements _i2.Response<T> {}

/// A class which mocks [HttpResponse].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpResponse<T> extends _i1.Mock implements _i3.HttpResponse<T> {
  MockHttpResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  T get data =>
      (super.noSuchMethod(Invocation.getter(#data), returnValue: null) as T);
  @override
  _i2.Response<dynamic> get response =>
      (super.noSuchMethod(Invocation.getter(#response),
          returnValue: _FakeResponse_0<dynamic>()) as _i2.Response<dynamic>);
  @override
  String toString() => super.toString();
}
