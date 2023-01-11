import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:somsomhouse/widgets/commentdign.dart';

class CommentPath extends StatefulWidget {
  const CommentPath({super.key});

  @override
  State<CommentPath> createState() => _CommentPathState();
}

class _CommentPathState extends State<CommentPath> {
//여기서 commentdidgn으로 댓글을 작성한 user데이터 값을 넘겨줌.
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Card(
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('comment')
                .orderBy('time',
                    descending: false) //time에 저장된 값이 있다면 그것으로 순서를 정렬해준다.
                //descending: true은 마지막 값이 위로
                .snapshots(),
            builder: (context, //스크림에서 가장 최신의 스냅샷을 가져오기위한 클래스
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } //데이터가 없을 경우를 대비해서 선언을 해줘야함.
              final commentdocs = snapshot.data!.docs;
              return ListView.builder(
                // reverse: true,//list가 보여지는 위치가 아래에서 위로 보여질 수 있도록 하는 선언
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CommentDign(
                    commentdocs[index]['text'], //index 번호, text형식
                    commentdocs[index]['userID'].toString() ==
                        user!.uid, //uid를 가져옴.
                    commentdocs[index]['userName'], //uid를 가져옴.
                    commentdocs[index]['image'],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
