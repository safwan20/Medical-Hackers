import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  return runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Center(
            child: Text('Medical-Hackers'),
          ),
        ),
        body: FilePick(),
      ),
    );
  }
}


class FilePick extends StatefulWidget {
  @override
  _FilePickState createState() => _FilePickState();
}

class _FilePickState extends State<FilePick> {

  void fileupload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      PlatformFile file = result.files.first;

      print('HELLO' + file.path);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Show(file.path)));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton.icon(
            onPressed: fileupload,
            icon: Icon(Icons.file_upload),
            label: Text("upload file")
        ),
      ),
    );
  }
}


