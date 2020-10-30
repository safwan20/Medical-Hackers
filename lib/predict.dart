import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Show extends StatefulWidget {
  Show(this.path);
  String path;

  @override
  State<StatefulWidget> createState() {
    return _ShowState(path);
  }
}

class _ShowState extends State<Show> {
  _ShowState(this.path);
  String path;
  String answer;
  Dio dio = new Dio();

  @override
  void initState() {
    pred();
    super.initState();
  }

  void pred() async {
    var uri = 'http://192.168.1.107:5000';
    String filename = path.split('/').last;


    FormData formData = new FormData.fromMap({
      "file" :
      await MultipartFile.fromFile(path,filename : filename,),
    });

    Response respose = await dio.post(uri, data:formData);
    print(respose.data);
    // Navigator.pop(context);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => Final(path,respose.data)));
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

