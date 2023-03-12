import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartinfo_model.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/dbservices.dart';
import 'package:somsomhouse/services/sqliteservices.dart';

class ApartInfo extends StatefulWidget {
  const ApartInfo({super.key});

  @override
  State<ApartInfo> createState() => _ApartInfoState();
}

class _ApartInfoState extends State<ApartInfo> {
  late IconData star;
  late SqliteHandler handler;
  late String apartName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    star = Icons.thumb_up_outlined;

    handler = SqliteHandler();

    handler.initializeDB();
    apartName = "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        selectApartmentInfo(),
        handler.isLike(ChartModel.apartName),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const Text('error');
        } else {
          var apartInfoModel = snapshot.data![0] as ApartInfoModel;
          List list = snapshot.data![1] as List;
          int isLike = int.parse(list[0]);

          if (isLike == 1) {
            star = Icons.thumb_up;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          apartInfoModel.apartinfoname,
                          textScaleFactor: 1.6,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (star == Icons.thumb_up_outlined) {
                              setState(() {
                                star = Icons.thumb_up;
                              });
                              handler.insert(ChartModel.apartName);
                            } else {
                              setState(() {
                                star = Icons.thumb_up_outlined;
                              });
                              handler.delete(ChartModel.apartName);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 30,
                            ),
                            child: Icon(
                              star,
                              color: Color.fromARGB(255, 44, 124, 244),
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(apartInfoModel.apartinfogu,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(134, 42, 37, 37))),
                          const Text(' / ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(134, 42, 37, 37))),
                          Text(apartInfoModel.apartinfodong,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(134, 42, 37, 37))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 1.0,
                        width: 600.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Text('전체 세대 수',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(134, 42, 37, 37))),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Text('난방방식',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(134, 42, 37, 37))),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Text(
                                '100', // snapshot.data!.apartinfohousehold.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              apartInfoModel.apartinfoheating,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 100),
                        Column(
                          children: [
                            const Text('평균 주차 대수',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(134, 42, 37, 37))),
                            Row(
                              children: const [
                                Text(''),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              apartInfoModel.apartinfoparking
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(''),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // ----------------------------------------------------------------
  /// 뷰에 아파트 정보를 가져오기 위해서 DB 서비스와 연결하는 함수
  /// 만든 날짜 : 2023.1.9
  /// 만든이 : 송명철
  Future<ApartInfoModel> selectApartmentInfo() async {
    DBServices dbServices = DBServices();
    ApartInfoModel apartInfoModel =
        await dbServices.callapartInfo(ChartModel.apartName);
    return apartInfoModel;
  }
}
//ChartModel.apartName
