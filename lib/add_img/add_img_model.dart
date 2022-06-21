import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddImgModel extends ChangeNotifier {
  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? title;
  String? imgurl;


  //firebaseの変更をリッスンしている
  Future <void> addImg() async {
    if (title == null) {
      throw 'タイトルが入力されていません。';
    }

    if (imgurl == null) {
      throw '画像URLが入力されていません。';
    }

    //firestoreに追加
    await FirebaseFirestore.instance.collection('images').add({
      'title':title,
      'imgurl':imgurl,
    });
  }
}