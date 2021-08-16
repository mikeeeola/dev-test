import 'package:equatable/equatable.dart';

class ServerErrorModel extends Equatable {
  final int? statusCode;
  final String? errorMessage;
  final dynamic data;

  ServerErrorModel({this.statusCode, this.errorMessage, this.data});

  @override
  List<Object> get props => [errorMessage!, statusCode!, data];

  @override
  bool get stringify => true;
}
