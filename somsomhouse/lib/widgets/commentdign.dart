import 'dart:ffi';

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
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          username,
                          textScaleFactor: 1.5, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${userTime.toDate().year}년 ${userTime.toDate().month}월 ${userTime.toDate().day}일 ${userTime.toDate().hour}시 ${userTime.toDate().minute}분',
                          textScaleFactor: 1, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          comment,
                          textScaleFactor: 1, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width -
                          50, //화면이 돌아가도 자동으로 양옆의 길이를 조절해주는 역할
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} //End
