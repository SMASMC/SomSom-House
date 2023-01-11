import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommentDign extends StatelessWidget {
  const CommentDign(this.comment, this.yesme, this.username, this.userImage,
      {super.key}); //받은 값을 바인드해줌.

  final String comment;
  final bool yesme;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 45, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: yesme
                      ? Color.fromARGB(255, 121, 119, 166)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                width: 150, //댓글창 크기
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
}
