import 'dart:io';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'contact_page.dart';
import 'home_page.dart';
import 'scan_eye.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  List _outputs;
  File _image;
  bool _loading = false;
  int _color = 0xffc248bd; //default pink

  CircularBottomNavigationController _navigationController;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Color(0xff00a5bd)),
    new TabItem(Icons.camera, "Scan Eye", Colors.green),
    new TabItem(Icons.photo_library, "Select Photo", Color(0xffff9000)),
    new TabItem(Icons.info, "About", Colors.black),
  ]);

  @override
  void initState() {
    super.initState();
    _loading = true;
    _navigationController = CircularBottomNavigationController(selectedPos);

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNav(),
          )
        ],
      ),
    );
  }

  bodyContainer() {
    switch (selectedPos) {
      case 0:
        return HomePage();
        break;
      case 1:
        return ScanEye();
        break;
      case 2:
        return openGallery();
        break;
      case 3:
        return ContactPage();
        break;
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }

  Widget openGallery() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,

        /*
        iconTheme: IconThemeData(color: Color(0xffff9000)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        */
        title: const Text(
          'Scan Photo from Gallery',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xffff9000),
          ),
        ),
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? Container()
                      : Image.file(_image,
                          color: Colors.grey,
                          colorBlendMode: BlendMode.saturation),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Text(
                          "Result: " + "${_outputs[0]["label"]}",
                          style: TextStyle(
                            color: Color(_color),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            // background: Paint()..color = Colors.transparent,
                          ),
                        )
                      : Container()
                ],
              ),
              decoration: BoxDecoration(
                // color: Colors.red[200],
                image: DecorationImage(
                    image: AssetImage("assets/images/back1.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: pickImage,
        icon: Icon(Icons.remove_red_eye),
        label: Text("Start"),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffff9000),
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    print(image);
    setState(() {
      _loading = true;
      _image = image;
    });

    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    setState(() {
      _loading = false;
      _outputs = output;
      if (_outputs[0]["index"] == 0) {
        _color = 0xff006400; //green
      } else if (_outputs[0]["index"] == 1) {
        _color = 0xffff0000; //red
      } else {
        print("Error!");
      }
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      await Tflite.loadModel(
        model: "assets/tflite/DR_Binary_1001.tflite",
        labels: "assets/tflite/labels.txt",
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }
}
