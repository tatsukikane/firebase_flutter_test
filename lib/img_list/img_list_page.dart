import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:firebase_flutter_test/edit_img/edit_img_page.dart';
import 'package:firebase_flutter_test/login/login_page.dart';
import 'package:firebase_flutter_test/mypage/my_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../add_img/add_img_page.dart';
import 'img_list_model.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
          actions: [
            IconButton(onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null){
                print('ログインしている');

                //画面遷移
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPage(),
                    fullscreenDialog: true,
                    ),
                );

              } else{
                print('ログインしていない');
                //画面遷移
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                    fullscreenDialog: true,
                    ),
                );

              }



            },
            icon: Icon(Icons.person)),
          ],
        ),
        body: Center(
          child: Consumer<ImgListModel>(builder: (context, model, child){
            final List<Imagedeta>? images = model.images;

            if (images == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = images.map(
              (image) => Slidable(
                key: const ValueKey(0),
                
                endActionPane:  ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (BuildContext context) async {
                       //画面遷移 add_img_pageへ
                      final String? title = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditImgPage(image),
                          ),
                      );
                      //追加が問題なく実行できた場合の、画面遷移後のpopup
                      if(title != null){
                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('$titleを編集しました。'),
                        );
                        //下記に行で
                        // ScaffoldMessenger.of(context)
                        //   .showSnackBar(snackBar);
                        Fluttertoast.showToast(
                            msg: "$titleを編集しました。",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      model.fetchImgList();

                    },
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: '編集',
                  ),
                  SlidableAction(
                    onPressed: (BuildContext context) async {
                      await showConfirmDialog(context, image, model);
                    },
                    backgroundColor: Color.fromARGB(255, 207, 13, 3),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: '削除',
                  ),
                ],
              ),

                child: ListTile(
                
                leading: image.imgurl != null
                      ? Image.network(image.imgurl!)
                      : null,
                  title: Text(image.title),
                  subtitle: Text(image.subtitle),
                  ),
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


  Future showConfirmDialog(BuildContext context, Imagedeta image, ImgListModel model,){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        title: Text("削除の確認"),
        content: Text("『${image.title}』を削除しますか?"),
        actions: [
          Builder(
            builder: (context) {
              return TextButton(
                child: Text("いいえ"),
                onPressed: () => Navigator.pop(context),
              );
            }
          ),
          Builder(
            builder: (context) {
              return TextButton(
                child: Text("はい"),
                onPressed: () async{
                  //modelで削除
                  await model.delete(image);
                  Navigator.pop(context);

                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('${image.title}を削除しました'),
                  );
                  model.fetchImgList();
                  ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
                },
              );
            }
          ),
        ],
      );
    },
  );

  }
}