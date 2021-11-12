import 'package:flutter/material.dart';
import 'package:genshin_info/services/api.dart';

class NationListPage extends StatefulWidget {
  const NationListPage({Key? key}) : super(key: key);

  @override
  _NationListPageState createState() => _NationListPageState();
}

class _NationListPageState extends State<NationListPage> {
  var _isLoading = false;
  var NationList;

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
          itemCount: NationList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/NationPage",
                    arguments: NationList[index],
                  );},
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        '${NationList[index]}',
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
    List list = await Api().fetch('nations');
    return list;
  }

  @override
  initState() {
    super.initState();

    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      NationList = value;
      setState(() {
        _isLoading = false;
      });
    });
  }
}
