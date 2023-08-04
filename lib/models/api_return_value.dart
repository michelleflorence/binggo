class ApiReturnValue<T> {
  final String? message;
  final T data;

  const ApiReturnValue({this.message, required this.data});
}
