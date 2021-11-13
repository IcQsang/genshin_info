import 'package:flutter/material.dart';
import 'package:genshin_info/models/nation.dart';
import 'package:genshin_info/services/api.dart';

class NationPage extends StatefulWidget {
  const NationPage({Key? key}) : super(key: key);

  @override
  _NationPageState createState() => _NationPageState();
}

class _NationPageState extends State<NationPage> {
  @override
  var _isLoading = false;
  late NationResult Nation;
  var first = true;

  Widget build(BuildContext context) {
    var NationName = ModalRoute.of(context)!.settings.arguments as String;
    if (first) {
      var Nation_F = _load(NationName);
      Nation_F.then((value) {
        Nation = value;
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
                        child: Text(
                          "${Nation.name}",
                          style: TextStyle(fontSize: fontsize),
                        ),
                      ))),
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "element:${Nation.element}",
                          style: TextStyle(fontSize: fontsize),
                        ),
                        Image.asset(
                          'assets/images/Element_${Nation.element}.png',height: fontsize,)
                      ],
                    ),
                  ))
            ],
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)),
              child: Center(
                  child: Text(
                    "archon:${Nation.archon}",
                    style: TextStyle(fontSize: fontsize),
                  ))),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)),
              child: Center(
                  child: Text(
                    "controllingEntity:${Nation.controllingEntity}",
                    style: TextStyle(fontSize: fontsize),
                  ))),
        ],
      ),
    );
  }

  Future<dynamic> _load(String item) async {
    var json = await Api().fetchMap('nations/$item');
    NationResult temp = NationResult.fromJson(json);

    return temp;
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
  }
}
