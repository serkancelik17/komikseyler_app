abstract class Response {
  bool success;
  dynamic data;
  String message;

  Response({this.success, this.data, this.message});
}
