import 'dart:io';

import 'package:flutter/material.dart';
import 'package:genshin_info/models/element.dart';
import 'package:genshin_info/services/api.dart';

class ElementPage extends StatefulWidget {
  const ElementPage({Key? key}) : super(key: key);

  @override
  _ElementPageState createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  @override
  var _isLoading = false;
  late ElementResult Element;
  var first = true;

  Widget build(BuildContext context) {
    var NationName = ModalRoute.of(context)!.settings.arguments as String;
    if (first) {
      var Nation_F = _load(NationName);
      Nation_F.then((value) {
        Element = value;
        setState(() {
          _isLoading = false;
        });
      });
      first = false;
    }
    var fontsize = 30.0;
    return _isLoading
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: Text(NationName),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Name:${Element.name}",
                                    style: TextStyle(fontSize: fontsize),
                                  ),
                                  Image.asset(
                                    'assets/images/Element_${Element.name}.png',
                                    height: fontsize,
                                  )
                                ],
                              ),
                            ))),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          "reaction",
                          style: TextStyle(fontSize: fontsize),
                        ),
                        Column(children: createReaction(),)
                      ],
                    ))),
              ],
            ),
          );
  }

  List<Widget> createReaction() {
    List<Widget> ans = [];
    for (dynamic x in Element.reaction) {
      String allElement = "";
      for (String e in x['elements']) {
        allElement += e + " ";
      }
      ans.add(Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Text("name:${x['name']}"),
            Text("Element:${allElement}"),
            Text("description:${x['description']}")
          ],
        ),
      ));
    }

    return ans;
  }

  Future<dynamic> _load(String item) async {
    var json = await Api().fetchMap('elements/$item');
    ElementResult temp = ElementResult.fromJson(json);

    return temp;
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
  }
}
