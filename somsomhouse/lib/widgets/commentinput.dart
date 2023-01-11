import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      margin: EdgeInsets.only(top: 8), //margin은 위치 지정이라 생각
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            maxLines: null, //글자입력의 한계를 없애준다.
            controller: _contoller,
            decoration: InputDecoration(
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

          icon: Icon(Icons.send),
          color: Colors.black,
        )
      ]),
    );
  }

//-------------------------------------Function
  void _sendComment() async {
    final user =
        FirebaseAuth.instance.currentUser; //firebase에서 해당되는 유저의 값을 가져올 수 있도록 함
    //firebasseauth는 firebase에 있는 저장되어 있는 값을 가져오거나 저장시키는 역할을 한다고 생각하면 됨.
    FocusScope.of(context).unfocus(); //텍스트를 입력한 이후에 텍스트 입력창이 내려갈 수 있도록 하는 기능
    final userData = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get(); //user 컬렉션에 저장되어있는 필드를 가져온다.

    FirebaseFirestore.instance.collection('comment').add({
      'text': _userEnterComment,
      'time': Timestamp
          .now(), //지금시간을 firebase에 add될수 있도록 함. TimeStamp는 cloud_firestore패키지에서 제공
      'userID': user.uid,
      'userName': userData.data()!['userName'],
      'image': userData.data()!['image'], //image url 을 가져옴.
    }); //Map형식으로 저장됨
    _contoller.clear(); //댓글 내용을 입력하고 나서 지워지도록 하는 선언
  }
}//End
