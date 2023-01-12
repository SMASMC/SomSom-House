import 'package:flutter/material.dart';

class CommentDign extends StatelessWidget {
  const CommentDign(this.comment, this.yesme, this.username, this.userImage,
      {super.key}); //받은 값을 바인드해줌.
//model느낌으로 사용하면서 model로 받아낸 값들을 바로 build에 적용시키는 흐름을 지닌 page이다.
  final String comment;
  final bool yesme;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    final _contoller = TextEditingController();
    var _userEnterComment = '';
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
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          username,
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
