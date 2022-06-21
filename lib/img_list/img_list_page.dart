import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import '../add_img/add_img_page.dart';
import 'img_list_model.dart';


class ImgListPage extends StatelessWidget {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('imags');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImgListModel>(
      create: (_) => ImgListModel()..fetchImgList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('画像一覧'),
        ),
        body: Center(
          child: Consumer<ImgListModel>(builder: (context, model, child){
            final List<Imagedeta>?images = model.images;

            if (images == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = images.map(
              (image) => ListTile(
                title: Text(image.title),
                subtitle: Text(image.imgurl),
                ),
              ).toList();


            return ListView(
              children: widgets,
              );
          }),
        ),
    
        floatingActionButton: 
          //戻る際の画面遷移に更新を入れてる
          Consumer<ImgListModel>(builder: (context, model, child){
            return FloatingActionButton(
              onPressed: () async {
                //画面遷移 add_img_pageへ
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddImgPage(),
                    fullscreenDialog: true,
                    ),
                );

                //追加が問題なく実行できた場合の、画面遷移後のpopup
                if(added != null && added){
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('景色の追加完了しました。'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                model.fetchImgList();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          }
        ), 
      ),
    );
  }
}