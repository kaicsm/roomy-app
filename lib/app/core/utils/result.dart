sealed class Result<T> {}

class Sucess<T> extends Result<T> {
  final T data;
  Sucess(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  Failure(this.message);
}
