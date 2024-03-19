class CriptoModel {
  bool? success;
  List<Result>? result;

  CriptoModel({this.success, this.result});

  CriptoModel.fromJson(Map<String, dynamic> json) {
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
  String? changeWeekstr;
  String? changeDaystr;
  String? changeHourstr;
  String? volumestr;
  String? pricestr;
  String? circulatingSupply;
  String? marketCapstr;
  String? code;
  String? name;

  Result(
      {this.currency,
      this.changeWeekstr,
      this.changeDaystr,
      this.changeHourstr,
      this.volumestr,
      this.pricestr,
      this.circulatingSupply,
      this.marketCapstr,
      this.code,
      this.name});

  Result.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    changeWeekstr = json['changeWeekstr'];
    changeDaystr = json['changeDaystr'];
    changeHourstr = json['changeHourstr'];
    volumestr = json['volumestr'];
    pricestr = json['pricestr'];
    circulatingSupply = json['circulatingSupply'];
    marketCapstr = json['marketCapstr'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['changeWeekstr'] = changeWeekstr;
    data['changeDaystr'] = changeDaystr;
    data['changeHourstr'] = changeHourstr;
    data['volumestr'] = volumestr;
    data['pricestr'] = pricestr;
    data['circulatingSupply'] = circulatingSupply;
    data['marketCapstr'] = marketCapstr;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
