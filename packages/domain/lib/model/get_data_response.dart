class GetDataResponse {
  final Map<String, List<String>> headers;
  final List<Map<String, dynamic>> body;

  const GetDataResponse({
    required this.headers,
    required this.body,
  });
}
