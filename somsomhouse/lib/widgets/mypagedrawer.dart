import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MypageDrawer extends StatefulWidget {
  const MypageDrawer({super.key});

  @override
  State<MypageDrawer> createState() => _MypageDrawerState();
}

class _MypageDrawerState extends State<MypageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, //상단바까지 색을 채우겠다.
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text('Pikachu'),
            accountEmail: Text('pikachu@naver.com'),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 121, 119, 166),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ), //only는 방향을 주는 역할을 함.
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text('Home'),
            trailing: Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
//-------------------Function 2023.01.12
/*
  void _sendComment() async {
    final user =
        FirebaseAuth.instance.currentUser; //firebase에서 해당되는 유저의 값을 가져올 수 있도록 함
    //firebasseauth는 firebase에 있는 저장되어 있는 값을 가져오거나 저장시키는 역할을 한다고 생각하면 됨.
    FocusScope.of(context).unfocus(); //텍스트를 입력한 이후에 텍스트 입력창이 내려갈 수 있도록 하는 기능
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get(); //user 컬렉션에 저장되어있는 필드를 가져온다.
    String apartmentname = '';
    apartmentname = ChartModel
        .apartName; //ChartModel값에저장된 아파트 이름을 collection(문서)로 넘겨서 문서이름을 변경하여 저장한다.
    FirebaseFirestore.instance.collection('board/$apartmentname/comment').add({
      'time': Timestamp
          .now(), //지금시간을 firebase에 add될수 있도록 함. TimeStamp는 cloud_firestore패키지에서 제공
      'userID': user.uid,
      'userName': userData.data()!['userName'], //user이름과 이미지를 저장해줌 comment에
      'image': userData.data()!['image'], //image url 을 가져옴.
      'text': _userEnterComment,
    }); //Map형식으로 저장됨
    _contoller.clear(); //댓글 내용을 입력하고 나서 지워지도록 하는 선언
  }


*/

}//End
