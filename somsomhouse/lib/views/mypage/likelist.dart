import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:somsomhouse/models/chart_model.dart';
import 'package:somsomhouse/services/sqliteservices.dart';
import 'package:somsomhouse/views/map/chartpage.dart';

class LikeList extends StatefulWidget {
  const LikeList({super.key});

  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  late SqliteHandler handler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = SqliteHandler();

    handler.initializeDB();
  }

  @override
  Widget build(BuildContext context) {
    final authentication = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('관심 아파트'),
        backgroundColor: const Color.fromARGB(232, 105, 183, 255),
        leading: const Icon(null),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              authentication.signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: handler.select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Colors.lightBlue,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ChartModel.apartName = snapshot.data![index];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChartPage(),
                        )).then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data![index],
                              textScaleFactor: 1.2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
