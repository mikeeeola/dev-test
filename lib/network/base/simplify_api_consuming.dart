import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dev_test/models/server_error_model.dart';
import 'package:dev_test/models/state.dart';
import 'package:flutter/material.dart' as material;

class SimplifyApiConsuming {
  SimplifyApiConsuming._();

  ///A more simplified method for making endpoint request call
  ///@param [requestFunction] a function passed, this function is the api call to execute
  ///@param [isStatusCode] a bool flag to indicate whether to equate response success with statusCode or with success string in response data
  ///@Param [statusCodeSuccess] an [int] status code to validate success of the request, if [isStatusCode] == true
  ///@Param [successResponse] a [Function] to execute if request is successful, must have a return statement
  /// Returns [Future<ResponseModel>]
  static Future<ServiceState> simplifyEndpointConsumingReturn(
      Future<Response<dynamic>> Function() requestFunction,
      {bool isStatusCode = true,
      int statusCodeSuccess = 200,
      @material.required ServiceState Function(dynamic data)? successResponse,
      ServiceState Function(Response data)? errorResponse,
      ServiceState Function(Response? data)? dioErrorResponse,
      Function(int)? statusCode}) async {
    try {
      return await _makeRequest(requestFunction, isStatusCode,
          statusCodeSuccess, successResponse, errorResponse);
    } on SocketException {
      return ServiceState<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: 400,
            errorMessage: "Something went wrong "
                "please check your internet connection and try again",
            data: null),
      );
    } on DioError catch (e) {
      print("dio error request is ${e.response}");
      return e.response != null
          ? ServiceState<ServerErrorModel>.error(
              ServerErrorModel(
                  statusCode: 400,
                  errorMessage: "Something went wrong please try again",
                  data: e.response!.data),
            )
          : ServiceState<ServerErrorModel>.error(
              ServerErrorModel(
                  statusCode: 400,
                  errorMessage: "Something went wrong please try again",
                  data: null),
            );
    } catch (error, stack) {
      print('error --------------------- ${error.toString()}');
      print('stack --------------------- ${stack.toString()}');

      return ServiceState<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: 400, errorMessage: error.toString(), data: null),
      );
    }
  }

  static Future<ServiceState> _makeRequest(
      Future<Response> requestFunction(),
      bool isStatusCode,
      int statusCodeSuccess,
      ServiceState successResponse(dynamic data)?,
      ServiceState errorResponse(Response data)?) async {
    var response = await requestFunction();

    if (isStatusCode) {
      return _handleResponseBasedOnStatusCode(
          response, statusCodeSuccess, successResponse, errorResponse);
    } else {
      return _handleResponseBasedOnDataReturned(
          response, successResponse!, errorResponse!);
    }
  }

  static ServiceState _handleResponseBasedOnStatusCode(
      Response response,
      int statusCodeSuccess,
      ServiceState successResponse(dynamic data)?,
      ServiceState? errorResponse(Response data)?) {
    if (response.statusCode == statusCodeSuccess) {
      return successResponse!(response.data);
    } else {
      return errorResponse!(response) ??
          ServiceState<ServerErrorModel>.error(
            ServerErrorModel(
                statusCode: response.statusCode,
                errorMessage: response.statusMessage ??
                    "Something went wrong please try again",
                data: response.data),
          );
    }
  }

  static ServiceState _handleResponseBasedOnDataReturned(
      Response response,
      ServiceState successResponse(dynamic data),
      ServiceState? errorResponse(Response data)) {
    if (response.data['status'] == 'success') {
      return successResponse(response.data);
    }
    return errorResponse(response) ?? ServiceState.error('An Error Occurred');
  }
}
