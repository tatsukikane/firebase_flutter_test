
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/image.dart';

class ImgListModel extends ChangeNotifier {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('imags');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  //?をつけるとnullを許容する
  List<Imagedeta>? images;

  //firebaseの変更をリッスンしている
  void fetchImgList(){
    //変化があったら、snapshotにデータが入る
    _imagesStream.listen((QuerySnapshot snapshot) {
        //DocumentSnapshot型からimagedeta型へ
        final List<Imagedeta> images = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String title = data['title'];
        final String imgurl = data['imgurl'];
        //image.dartで作った形にしてリターン
        return Imagedeta(title,imgurl);
        }).toList();
        this.images = images;
        notifyListeners();  //listpageのConsumerの部分が発火する
     });


    // snapshot.data!.docs.map((DocumentSnapshot document) {
    //       Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //         return ListTile(
    //           title: Text(data['title']),
    //           subtitle: Text(data['imgurl']),
    //         );
    //       }).toList(),
  }

}