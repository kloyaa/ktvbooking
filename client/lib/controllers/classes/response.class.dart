class ApiResponse {
  final String message;
  final String code;
  final String data;
  ApiResponse({required this.message, required this.code, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      code: json['code'],
      data: json['data'],
    );
  }
}
