import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:somsomhouse/widgets/commentinput.dart';
import 'package:somsomhouse/widgets/commentpath.dart';

class Comment extends StatefulWidget {
  const Comment({super.key});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final _authentication =
      FirebaseAuth.instance; //firebaseauth로 firebase에 값을 저장하는 역할을 함.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CommentInput(),
          CommentPath(), //listview가 모든 공간을 확보하기 때문에, Expanded 위젯으로 감싸줘야함.
        ],
      ),
    );
  }
}
///comment/2JZdEdR8CYO0IpQ9RqxT/contents/ZP1N38lZrjlsswTR8qoO