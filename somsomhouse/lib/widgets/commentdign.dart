import 'package:flutter/material.dart';
import 'package:somsomhouse/models/comment_model.dart';

class CommentDign extends StatelessWidget {
  const CommentDign({super.key}); //받은 값을 바인드해줌.

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
                CommentModel.username,
                textScaleFactor: 1.5, //기기마다 폰트 사이즈 맞춰주는 역할을 함.
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${CommentModel.userTime.toDate().year}년 ${CommentModel.userTime.toDate().month}월 ${CommentModel.userTime.toDate().day}일 ${CommentModel.userTime.toDate().hour}시 ${CommentModel.userTime.toDate().minute}분',
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
            CommentModel.comment,
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
