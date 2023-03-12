import 'package:flutter/material.dart';
import 'package:somsomhouse/views/map/map.dart';
import 'package:somsomhouse/views/mypage/likelist.dart';
import 'package:somsomhouse/views/predict/seoul/predict.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // field
  late TabController controller;

// initState
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // tabBar mapping을 하는 것이라고 보면 된다.
    controller = TabController(
      // tab의 갯수
      length: 3,
      // this는 tab의 요소들을 의미한다.
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
        controller: controller,
        children: const [
          Map(),
          Predict(),
          LikeList(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.height * 0,
          MediaQuery.of(context).size.width * 0.04,
          MediaQuery.of(context).size.height * 0.05,
        ),
        decoration: const BoxDecoration(
          color: Color.fromARGB(246, 105, 183, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: TabBar(
          controller: controller,
          indicatorColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(159, 255, 255, 255),
          tabs: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.apartment_rounded),
                  Text('아파트 정보'),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.money),
                  Text('보증금 예측'),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.list_alt_outlined),
                  Text('관심 아파트'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
