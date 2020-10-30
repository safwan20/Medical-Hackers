import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'image_show.dart';


class Final extends StatefulWidget {
  Final(this.answer);
  var answer = new Map();
  @override
  State<StatefulWidget> createState() {
    return _FinalState(answer);
  }
}

class _FinalState extends State<Final> {
  _FinalState(this.answer);
  var answer = new Map();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Center(
            child: Text('MediFit'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text( 'Your maximum beats are: ' + answer['beats']),
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Alert(
                          context: context,
                          title: "Heart rate",
                          desc: answer['rate'].toString() + " per sec"
                        ).show();
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                              'Your Heart Rate'
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Alert(
                          context: context,
                          title: "In Production",
                          desc: "Soon into development (details about the disease)",
                        ).show();
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                              'Your maximum beats are: ' + answer['beats']
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (context) => SpinnerThree(path)));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                                'Show Wheezle and Crackles'
                            ),
                          ),
                        )
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SpinnerTwo()));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                              'Show Pie Chart'
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



