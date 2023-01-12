import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/models/comment_model.dart';

class CommentDign extends StatelessWidget {
  const CommentDign({super.key}); //받은 값을 바인드해줌.

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
                          CommentModel.username,
                          textScaleFactor: 1.5, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${CommentModel.userTime.toDate().year}년 ${CommentModel.userTime.toDate().month}월 ${CommentModel.userTime.toDate().day}일 ${CommentModel.userTime.toDate().hour + 9}시 ${CommentModel.userTime.toDate().minute}분',
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
                          CommentModel.comment,
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
