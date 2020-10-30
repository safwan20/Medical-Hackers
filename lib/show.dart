import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

//import 'package:intro_slider_example/home.dart';


class Yh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
        title: Center(
        child: Text('Medical-Hackers'),
    ),
    ), body: IntroScreen(),
    ),
    );
  }
}


class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Bundle branch block beats",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        "These beats are usually not that big of an issue.But needs medical attention if you feel lightheaded or dizzy or faint. It is recommended to get yourself checked.",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily: 'Raleway'),
        pathImage: "images/bundle.png"
      ),
    );
    slides.add(
      new Slide(
        title: "Premature Beat",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description: "These types of beats occur in many healthy people and rarely cause any harmful symptoms to individuals. old age people affected the most. ",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily: 'Raleway'),
        pathImage: "images/premature.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Supra-Ventricular Beats",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        "If you have occasional premature ventricular contractions, but you're otherwise healthy, there's probably no reason for concern, and no need for treatment.",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily: 'Raleway'),
        pathImage:"images/ventri.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Fusion Beats",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        " These kinds of beats occur when two pacemakers of the heart coincide to produce a hybrid complex.Check is must ",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily: 'Raleway'),
        pathImage:  "images/fusion.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "Escape Beats",
        styleTitle:
        TextStyle(color: Color(0xff3da4ab), fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),
        description:
        "The ventricular escape beat follows a long pause in ventricular rhythm and acts to prevent cardiac arrest. It indicates a failure of the electrical conduction system. Checkup is must",
        styleDescription:
        TextStyle(color: Color(0xfffe9c8f), fontSize: 20.0, fontStyle: FontStyle.normal, fontFamily: 'Raleway'),
        pathImage: "images/escape.jpg",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    this.goToTab(0);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                    currentSlide.pathImage,
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),

      // Dot indicator
      colorDot: Color(0xffffcc5c),
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}




