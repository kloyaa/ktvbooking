import 'package:app/const/api.const.dart';
import 'package:app/controllers/classes/response.class.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  final accessToken = "".obs;

  final response = Rx<ApiResponse>(
    ApiResponse(
      message: '',
      code: '00',
      data: '',
    ),
  );

  Future<dynamic> login(String username, String password) async {
    try {
      isLoading.value = true;
      final response = await _dio.post(
        Api.login,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: headers), // Pass the headers here
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data);
        this.response.value = apiResponse;
        accessToken.value = apiResponse.data;

        return apiResponse.code;
      } else {
        this.response.value = ApiResponse(
          message: 'Failed to connect to the server',
          code: '99',
          data: '',
        );
      }
    } on DioException catch (e) {
      response.value = ApiResponse(
        message: e.response?.data["message"],
        code: e.response?.data["code"],
        data: e.response?.data["data"] ?? "",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> register(
    String username,
    String password,
    String email,
  ) async {
    try {
      isLoading.value = true;
      print({
        'email': email,
        'username': username,
        'password': password,
      });
      final response = await _dio.post(
        Api.register,
        data: {
          'email': email,
          'username': username,
          'password': password,
        },
        options: Options(headers: headers), // Pass the headers here
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(response.data);
        this.response.value = apiResponse;

        return apiResponse;
      } else {
        this.response.value = ApiResponse(
          message: 'Failed to connect to the server',
          code: '99',
          data: '',
        );
      }
    } on DioException catch (e) {
      response.value = ApiResponse(
        message: e.response?.data["message"],
        code: e.response?.data["code"],
        data: e.response?.data["data"] ?? "",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
