import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_album_manager/album_model_entity.dart';

class Photo extends StatefulWidget {
  AlbumModelEntity value;
  Photo({Key key, this.value}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
            tag: widget.value.localIdentifier,
            child: Image.file(
              File(widget.value.originalPath),
            )),
      ),
    );
  }
}
