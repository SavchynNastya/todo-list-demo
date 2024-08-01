class ServerError {
  String? detail;
  int? code;

  ServerError({this.detail, this.code});

  ServerError.fromJson(Map<String, dynamic> json) {
    detail = json['message'];
    code = json['internal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['detail'] = this.detail;
    data['internal_code'] = this.code;
    return data;
  }
}
