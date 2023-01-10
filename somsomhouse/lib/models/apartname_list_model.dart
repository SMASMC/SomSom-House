import 'package:somsomhouse/models/apartname_model.dart';

class ApartNameListModel {
  final List<ApartNameModel> apartNameListModel;

  ApartNameListModel({required this.apartNameListModel});

  factory ApartNameListModel.fromJson(Map<String, dynamic> json) =>
      ApartNameListModel(
        apartNameListModel: (json['results'] as List<dynamic>)
            .map((e) => ApartNameModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'apartNameListModel': apartNameListModel,
      };
}
