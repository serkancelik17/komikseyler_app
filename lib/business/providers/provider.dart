abstract class Provider {
  Future<String> getResponse(String endpoint);
  Future<String> postResponse(String endpoint, String body);
}
