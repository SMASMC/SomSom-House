class ApartInfoModel {
  String apartinfoname = '';
  String apartinfogu = '';
  String apartinfodong = '';
  String apartinfoheating = '';
  int apartinfohousehold = 0;
  double apartinfoparking = 0;

  ApartInfoModel({
    required this.apartinfoname,
    required this.apartinfogu,
    required this.apartinfodong,
    required this.apartinfoheating,
    required this.apartinfohousehold,
    required this.apartinfoparking,
  });

  factory ApartInfoModel.fromJson(Map<String, dynamic> json) => ApartInfoModel(
        apartinfoname: (json['name'] as String),
        apartinfogu: (json['gu'] as String),
        apartinfodong: (json['dong'] as String),
        apartinfoheating: (json['heating'] as String),
        apartinfohousehold: (json['household'] as num).toInt(),
        apartinfoparking: (json['parking'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': apartinfoname,
        'gu': apartinfogu,
        'dong': apartinfodong,
        'heating': apartinfoheating,
        'household': apartinfohousehold,
        'parking': apartinfoparking,
      };
}
