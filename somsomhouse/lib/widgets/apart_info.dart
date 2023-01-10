import 'package:flutter/material.dart';
import 'package:somsomhouse/models/apartinfo_model.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/dbservices.dart';

class ApartInfo extends StatefulWidget {
  const ApartInfo({super.key});

  @override
  State<ApartInfo> createState() => _ApartInfoState();
}

class _ApartInfoState extends State<ApartInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selectApartmentInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return Text('error');
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          snapshot.data!.apartinfoname,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(snapshot.data!.apartinfogu,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(134, 42, 37, 37))),
                          const Text(' / ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(134, 42, 37, 37))),
                          Text(snapshot.data!.apartinfodong,
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
                              snapshot.data!.apartinfoheating,
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
                              snapshot.data!.apartinfoparking
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
