class ResponseData {
  final bool success;
  final List<dynamic> data;
  final int total;

  const ResponseData(
      {required this.success, required this.data, required this.total});
}
