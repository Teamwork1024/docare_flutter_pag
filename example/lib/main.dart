import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pag/pag.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  GlobalKey<PAGViewState> _fansDanceKey =
      GlobalKey<PAGViewState>(debugLabel: _assetFans);
  GlobalKey<PAGViewState> _assetDanceKey =
      GlobalKey<PAGViewState>(debugLabel: _assetFans);

  GlobalKey<PAGViewState> get assetPagKey =>
      _pagAsset == _assetFans ? _fansDanceKey : _assetDanceKey;

  final GlobalKey<PAGViewState> networkPagKey = GlobalKey<PAGViewState>();
  final GlobalKey<PAGViewState> bytesPagKey = GlobalKey<PAGViewState>();

  Uint8List? bytesData;

  // 本地加载资源
  static const String _assetFans = 'data/fans.pag';
  static const String _assetTest = 'data/test.pag';
  static const String _assetImage = 'data/amy.png';
  static const String _assetDance = 'data/dance.pag';
  static const String _assetError = 'data/error.pag';
  String _pagAsset = _assetTest;

  void changeAsset() {
    setState(() {
      _pagAsset = _pagAsset == _assetFans ? _assetDance : _assetFans;
    });
  }

  @override
  void initState() {
    rootBundle.load("data/fans.pag").then((data) {
      setState(() {
        bytesData = Uint8List.view(data.buffer);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Container(
        child: PAGView.asset(
          _pagAsset,
          repeatCount: PAGView.REPEAT_COUNT_LOOP,
          autoPlay: true,
          width: double.infinity,
          height: double.infinity,
          key: assetPagKey,
          replaceImgName: _assetImage,
          replaceImgIndex: 2,
        ),
      ),
    );
  }
}
