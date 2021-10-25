class HTTPResponse<T> {
  bool? isSuccessfull;
  T? data;
  String? message;
  int? responseCode;

  HTTPResponse(this.isSuccessfull, this.data,
      {this.message, this.responseCode});
}
