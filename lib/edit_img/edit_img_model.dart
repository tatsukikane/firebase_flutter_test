import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/image.dart';


class EditImgModel extends ChangeNotifier {
  final Imagedeta image;
  EditImgModel(this.image) {
    titleController.text = image.title;
    subtitleController.text = image.subtitle;
  }


  final titleController = TextEditingController();
  final subtitleController = TextEditingController();



  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? title;
  String? subtitle;

  void setTitle(String title){
    this.title = title;
    notifyListeners();
  }

  void setImageurl(String subtitle){
    this.subtitle = subtitle;
    notifyListeners();
  }

  bool isUpdated(){
    return title != null || subtitle != null;
  }


  //firebaseの変更をリッスンしている
  Future update() async {
    this.title = titleController.text;
    this.subtitle = subtitleController.text;


    // if (title == null) {
    //   throw 'タイトルが入力されていません。';
    // }

    // if (imgurl == null) {
    //   throw '画像URLが入力されていません。';
    // }

    //firestoreのデータを変更
    await FirebaseFirestore.instance.collection('imags').doc(image.id).update({
      'title':title,
      'subtitle':subtitle,
    });
  }
}