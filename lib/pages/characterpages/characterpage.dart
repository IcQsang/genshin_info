import 'package:flutter/material.dart';
import 'package:genshin_info/models/character.dart';
import 'package:genshin_info/services/api.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  @override
  var _isLoading = false;
  late CharacterResult character;
  var first = true;

  Widget build(BuildContext context) {
    var charactername = ModalRoute.of(context)!.settings.arguments as String;
    if (first) {
      var character_F = _load(charactername);
      character_F.then((value) {
        character = value;
        setState(() {
          _isLoading = false;
        });
      });
      first = false;
    }
    var birth;
    if (!_isLoading) {
      birth = character.birthday.split("-");
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
              title: Text(charactername),
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
                                "Name:${character.name}",
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
                        "Vision:${character.vision}",
                        style: TextStyle(fontSize: fontsize),
                      ),
                      Image.asset(
                          'assets/images/Element_${character.vision}.png',height: fontsize,)
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
                      "Weapon:${character.weapon}",
                      style: TextStyle(fontSize: fontsize),
                    ))),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < character.rarity; i++)
                          Icon(
                            Icons.star,
                            size: fontsize,
                            color: Colors.yellow,
                          ),
                        for (int i = 0; i < 5 - character.rarity; i++)
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
                    child: Center(
                        child: Text(
                      "birthday: ${birth[2]} ${birth[1]}  ",
                      style: TextStyle(fontSize: fontsize),
                    )))
              ],
            ),
          );
  }

  Future<dynamic> _load(String item) async {
    var json = await Api().fetchMap('characters/$item');
    CharacterResult temp = CharacterResult.fromJson(json);

    return temp;
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
  }
}
