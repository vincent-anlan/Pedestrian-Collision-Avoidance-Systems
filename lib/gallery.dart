import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_album_manager/photo_album_manager.dart';
import 'package:road_hackers/photo_detail.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<AlbumModelEntity> photos = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    photos = await PhotoAlbumManager.getDescAlbumImg(maxCount: 30);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Gallery'),
        centerTitle: true,
      ),
      body: new GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          AlbumModelEntity model = photos[index];
          return GestureDetector(
            child: Card(
              child: Stack(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: Hero(
                      tag: model.localIdentifier,
                      child: Image.file(
                        File(model.thumbPath ?? model.originalPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Offstage(
                    child: Center(
                      child: Icon(Icons.play_circle_outline),
                    ),
                    offstage: model.resourceType == "image" ? true : false,
                  ),
                ],
              ),
            ),
            onTap: () {
              PhotoAlbumManager.getOriginalImg(model.localIdentifier,
                  onProgress: (progress) {
                print("下载进度" + progress.toString());
              }, onError: (error) {
                print("下载错误" + error);
              }).then((value) {
                print("下载完成" + value.originalPath);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Photo(value: value)));
              });
            },
          );
        },
      ),
    );
  }
}
