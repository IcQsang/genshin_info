import 'package:flutter/material.dart';
import 'package:genshin_info/services/api.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({Key? key}) : super(key: key);

  @override
  _CharacterListPageState createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  var _isLoading = false;
  var CharacterList;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ))
        : Container(
            child: ListView.builder(
                itemCount: CharacterList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/CharacterPage",
                        arguments: CharacterList[index],
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              '${CharacterList[index]}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  Future<List> _load() async {
    List list = await Api().fetch('characters');
    return list;
  }

  @override
  initState() {
    super.initState();
    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      CharacterList = value;
      setState(() {
        _isLoading = false;
      });
    });
  }
}
