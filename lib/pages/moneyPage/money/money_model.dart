class MoneyModel {
  bool? success;
  List<Result>? result;

  MoneyModel({this.success, this.result});

  MoneyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? name;
  double? buying;
  double? selling;

  Result({this.name, this.buying, this.selling});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    buying = json['buying'];
    selling = json['selling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['buying'] = buying;
    data['selling'] = selling;
    return data;
  }
}
