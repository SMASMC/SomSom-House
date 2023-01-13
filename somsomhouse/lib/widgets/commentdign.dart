import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentDign extends StatelessWidget {
  const CommentDign(this.comment, this.yesme, this.username, this.userTime,
      {super.key}); //받은 값을 바인드해줌.
//model느낌으로 사용하면서 model로 받아낸 값들을 바로 build에 적용시키는 흐름을 지닌 page이다.
  final String comment;
  final bool yesme;
  final String username;
  final Timestamp userTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username,
                textScaleFactor: 1.5, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${userTime.toDate().year}년 ${userTime.toDate().month}월 ${userTime.toDate().day}일 ${userTime.toDate().hour}시 ${userTime.toDate().minute}분',
                textScaleFactor: 1, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                style: const TextStyle(
                  color: Color.fromARGB(176, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            comment,
            textScaleFactor: 1, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
} //End
