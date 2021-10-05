abstract class Resource<T> {
  final T data;
  const Resource(this.data);
}

class SuccessResource<T> extends Resource<T> {
  const SuccessResource(T data) : super(data);
}

class FailedResource<T> extends Resource<T> {
  final String? message;
  const FailedResource(T data, {this.message}) : super(data);
}
