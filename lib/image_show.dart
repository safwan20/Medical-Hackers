import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:heartss/spectogram.dart';

class SpinnerTwo extends StatefulWidget {
  SpinnerTwo();

  @override
  State<StatefulWidget> createState() {
    return _SpinnerTwoState();
  }
}


class _SpinnerTwoState extends State<SpinnerTwo> {
  _SpinnerTwoState();
  String answer, path;
  Dio dio = new Dio();
  Image img;

  @override
  void initState() {
    show();
    super.initState();
  }

  void show () async{
    var uri = 'http://192.168.1.107:5000/show_image';

    Response respose = await dio.get(uri);
    img = Image.memory(base64Decode(respose.data));
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Spectogram(img)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.grey,
          size: 100.0,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

