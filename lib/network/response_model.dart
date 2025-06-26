class ResponseModel {
  bool? status;
  String? message;
  dynamic data;

  ResponseModel(this.status, this.data, this.message);

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
      json['status'], json['data'], json['message'] ?? json['msg']);
}
