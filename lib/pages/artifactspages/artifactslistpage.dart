import 'package:flutter/material.dart';
import 'package:genshin_info/services/api.dart';

class ArtifactsListPage extends StatefulWidget {
  const ArtifactsListPage({Key? key}) : super(key: key);

  @override
  _ArtifactsListpageState createState() => _ArtifactsListpageState();
}

class _ArtifactsListpageState extends State<ArtifactsListPage> {
  var _isLoading = false;
  var ArtifactsList;

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
          itemCount: ArtifactsList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/ArtifactPage",
                  arguments: ArtifactsList[index],
                );},
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '${ArtifactsList[index]}',
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
    List list = await Api().fetch('artifacts');
    return list;
  }

  @override
  initState() {
    super.initState();

    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      ArtifactsList = value;
      setState(() {
        _isLoading = false;
      });
    });
  }
}
