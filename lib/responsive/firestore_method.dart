import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram/model/post.dart';
import 'package:instagram/resources/stoage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String ProfImage,
  ) async {
    String res = "some error";
    try {
      String photourl =
          await StorageMethods().uploadImageToString("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        postId: postId,
        username: username,
        datePublished: DateTime.now(),
        postUrl: photourl,
        ProfImage: ProfImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> postComment(
      String uid, String text, String name, String commentid) async {
    try {
      if (text.isNotEmpty) {
        String commentid = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(uid)
            .collection('comments')
            .doc(commentid)
            .set({
          'uid': uid,
          'name': name,
          'text': text,
          'commentid': commentid,
        });
      } else {
        print('test is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

//delete a post
  Future<void> deletePost(String uid) async {
    try {
      _firestore.collection('posts').doc(uid).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followID) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data() as dynamic)['following'];
      if (following.contains(followID)) {
        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followID])
        });
      } else {
        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followID])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
