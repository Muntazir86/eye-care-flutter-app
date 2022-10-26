import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 5),
              ),
              Padding(
                child: new Container(
                  child: new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.phone_iphone,
                                  color: Color(0xff00a5bd), size: 30),
                              title: new Text(
                                'Summary',
                                style: new TextStyle(
                                    fontFamily: "SF UI Display",
                                    fontSize: 18,
                                    color: Color(0xff00a5bd),
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                '\nThe scope of this study is to detect the stage of DR in patients easily and early as possible with a mobile phone camera and a convolutional neural network that is trained with different images of DR using deep learning and image processing.',
                                style: TextStyle(
                                    fontFamily: "SF UI Display",
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                ),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 5),
              ),
              Padding(
                child: new Container(
                  child: new Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.remove_red_eye,
                                  color: Color(0xff00a5bd), size: 30),
                              title: new Text(
                                'What is DR?',
                                style: new TextStyle(
                                    fontFamily: "SF UI Display",
                                    fontSize: 16,
                                    color: Color(0xff00a5bd),
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                '\nIt has been proven by specialists that with the progression of diabetes, it causes various complications in the human body. The most prominent of these complications happens in the eyes. Because of diabetes, veins in retina become damaged and starts to leak or swollen. This results in blurry vision or even blindness.',
                                style: TextStyle(
                                    fontFamily: "SF UI Display",
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  padding: const EdgeInsets.all(0.0),
                  alignment: Alignment.center,
                ),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 5),
              ),
            ],
          ),
        ),
      )),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/back1.jpg"), fit: BoxFit.cover),
      ),
    ));
  }
}
