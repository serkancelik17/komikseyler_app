abstract class Provider {
  Future<String> get(String endpoint);
  Future<String> post(String endpoint, String body);
}
