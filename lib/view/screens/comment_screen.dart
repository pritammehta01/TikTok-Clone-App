// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_shok/controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({required this.id});
  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostID(id);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, index) {
                    final comment = commentController.comments[index];
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(comment.profilePic),
                        ),
                        title: Row(
                          children: [
                            Text(
                              comment.username,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              comment.comment,
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePub.toDate()),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${comment.likes.length} Likes",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                            onTap: () {
                              commentController.likeComment(comment.id);
                            },
                            child: Icon(Icons.favorite,
                                color: comment.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.white)));
                  },
                );
              }),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  controller: _commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(CupertinoIcons.chat_bubble),
                      hintText: "Comments",
                      suffixIcon: TextButton(
                          onPressed: () {
                            log(_commentController.text);
                            commentController
                                .postComment(_commentController.text);
                          },
                          child: const Text("Post"))),
                )),
          ],
        ),
      ),
    );
  }
}
