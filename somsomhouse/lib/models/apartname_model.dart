class ApartNameModel {
  String apartName = "";

  ApartNameModel({required this.apartName});

  factory ApartNameModel.fromJson(Map<String, dynamic> json) => ApartNameModel(
        apartName: (json['name'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{'name': apartName};
}
