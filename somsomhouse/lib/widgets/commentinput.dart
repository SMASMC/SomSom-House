import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/chart_model.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _contoller = TextEditingController();
  var _userEnterComment = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 8), //margin은 위치 지정이라 생각
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null, //글자입력의 한계를 없애준다.
              controller: _contoller,
              decoration: const InputDecoration(
                labelText: '댓글 달기',
              ),
              onChanged: (value) {
                setState(() {
                  _userEnterComment = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterComment.trim().isEmpty
                ? null
                : _sendComment, //메서드 뒤에 괄호가 없는 경우는
            // onpressed 메서드가 _sendComment메서드의 위치를 참조한다.

            icon: const Icon(Icons.send),
            color: Colors.black,
          )
        ],
      ),
    );
  }

//-------------------------------------Function 2023-01-12
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
      'text': _userEnterComment,
    }); //Map형식으로 저장됨
    _contoller.clear(); //댓글 내용을 입력하고 나서 지워지도록 하는 선언
  }
}//End
