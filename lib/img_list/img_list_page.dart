import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
    
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), 
      ),
    );
  }
}