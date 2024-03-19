class BourseModel {
  bool? success;
  List<Result>? result;

  BourseModel({this.success, this.result});

  BourseModel.fromJson(Map<String, dynamic> json) {
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
  String? currency;
  String? name;
  String? pricestr;

  String? time;

  Result({this.currency, this.name, this.pricestr, this.time});

  Result.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    name = json['name'];
    pricestr = json['pricestr'];

    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['name'] = name;
    data['pricestr'] = pricestr;

    data['time'] = time;
    return data;
  }
}
