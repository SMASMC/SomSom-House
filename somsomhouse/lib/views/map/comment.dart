import 'package:flutter/material.dart';
import 'package:somsomhouse/widgets/commentinput.dart';
import 'package:somsomhouse/widgets/commentpath.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

//firebaseauth로 firebase에 값을 저장하는 역할을 함.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CommentInput(),
        CommentPath(), //listview가 모든 공간을 확보하기 때문에, Expanded 위젯으로 감싸줘야함.
      ],
    );
  }
}
