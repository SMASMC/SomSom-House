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
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: yesme
                      ? Color.fromARGB(255, 121, 119, 166)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Text(
                      comment,
                      style: TextStyle(
                        color: yesme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 20,
          left: 100,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}//End
