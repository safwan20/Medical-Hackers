import 'package:flutter/material.dart';


class Spectogram extends StatefulWidget {
  Spectogram(this.img);
  Image img;

  @override
  State<StatefulWidget> createState() {
    return _SpectogramState(img);
  }
}

class _SpectogramState extends State<Spectogram> {
  _SpectogramState(this.img);
  Image img;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("MediFite"),
      ),
      body: Column(
        children: [
          Text("Your Beat Pie Chart"),
          Expanded(
              child: img)
        ],
      ),
    );
  }
}