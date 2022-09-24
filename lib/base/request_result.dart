class RequestResult<T> {
  final bool result;
  final T? value;

  RequestResult(this.result, {this.value});
}