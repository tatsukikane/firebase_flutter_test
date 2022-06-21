import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'edit_img_model.dart';


class EditImgPage extends StatelessWidget {
  final Imagedeta image;
  EditImgPage(this.image);

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('imags');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditImgModel>(
      create: (_) => EditImgModel(image),
      child: Scaffold(
        appBar: AppBar(
          title: Text('編集'),
        ),
        body: Center(
          child: Consumer<EditImgModel>(builder: (context, model, child){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
              TextField(
                controller: model.titleController,
                decoration: InputDecoration(
                  hintText: '写真のタイトル',
                ),
                onChanged: (text) {
                  model.setTitle(text);
                },
              ),

              const SizedBox(
                height: 8,
              ),
            
              TextField(
                controller: model.imgurlController,
                decoration: InputDecoration(
                  hintText: '写真のurl',
                ),
                onChanged: (text) {
                  model.setImageurl(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: model.isUpdated()
                //updateされていた場合は以下の処理を実行
                ? () async {
                //追加の処理
                try{
                  await model.update();
                  Navigator.of(context).pop(model.title);
                } catch(err) {
                  //エラーの出力
                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(err.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } : null,
              child: Text('更新する'),
              ),
                      ],
                    ),
            );
      }),
    ),
    
      ),
    );
  }
}