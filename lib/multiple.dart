import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Final.dart';

class Multi extends StatefulWidget {
  Multi(this.f);
  List<File> f;

  @override
  State<StatefulWidget> createState() {
    return _MultiState(f);
  }
}

class _MultiState extends State<Multi> {
  _MultiState(this.f);
  List<File> f;
  String answer;
  Dio dio = new Dio();

  @override
  void initState() {
    pred();
    super.initState();
  }

  void pred() async {
    var uri = 'http://192.168.1.107:5000';
    // String filename = path.split('/').last;

    var li = new List();

    print(f);

    for(var h in f) {
      li.add(MultipartFile.fromFileSync(h.path,
          filename: h.path.split('/').last),);
    }

    FormData formData = new FormData.fromMap({
      "file" : li
    });

    Response respose = await dio.post(uri, data:formData);

    print(respose.data);

    Navigator.pop(context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Final(respose.data)));
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

