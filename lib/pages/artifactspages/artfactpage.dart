import 'package:flutter/material.dart';
import 'package:genshin_info/models/artifact.dart';
import 'package:genshin_info/services/api.dart';

class ArtifactPage extends StatefulWidget {
  const ArtifactPage({Key? key}) : super(key: key);

  @override
  _ArtifactPageState createState() => _ArtifactPageState();
}

class _ArtifactPageState extends State<ArtifactPage> {
  @override
  var _isLoading = false;
  late ArtifactResult artifact;
  var first = true;

  Widget build(BuildContext context) {
    var artifactname = ModalRoute.of(context)!.settings.arguments as String;
    if (first) {
      var artifact_F = _load(artifactname);
      artifact_F.then((value) {
        artifact = value;
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
        title: Text(artifactname),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)),
              child: Center(
                child: Text(
                  "Name:${artifact.name}",
                  style: TextStyle(fontSize: fontsize),
                ),
              )),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Max_Rarity:",style: TextStyle(fontSize: fontsize),),
                  for (int i = 0; i < artifact.max_rarity; i++)
                    Icon(
                      Icons.star,
                      size: fontsize,
                      color: Colors.yellow,
                    ),
                  for (int i = 0; i < 5 - artifact.max_rarity; i++)
                    Icon(
                      Icons.star_border,
                      size: fontsize,
                      color: Colors.yellow,
                    )
                ],
              ),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)),
              child: Text(
                "2-piece_bonus:${artifact.piece_bonus_2}",
                style: TextStyle(fontSize: fontsize),
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)),
              child: Text(
                "4-piece_bonus:${artifact.piece_bonus_4}",
                style: TextStyle(fontSize: fontsize),
              )),

        ],
      ),
    );
  }

  Future<dynamic> _load(String item) async {
    var json = await Api().fetchMap('artifacts/$item');
    ArtifactResult temp = ArtifactResult.fromJson(json);
    return temp;
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
  }
}
