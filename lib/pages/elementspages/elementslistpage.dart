import 'package:flutter/material.dart';
import 'package:genshin_info/services/api.dart';

class ElementListPage extends StatefulWidget {
  const ElementListPage({Key? key}) : super(key: key);

  @override
  _ElementListPageState createState() => _ElementListPageState();
}

class _ElementListPageState extends State<ElementListPage> {
  var _isLoading = false;
  var ElementList;

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
          itemCount: ElementList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/ElementPage",
                  arguments: ElementList[index],
                );},
              child: Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/Element_${ElementList[index]}.png',height: 40)
                    ,
                      Text(
                        '${ElementList[index]}',
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
    List list = await Api().fetch('elements');
    return list;
  }

  @override
  initState() {
    super.initState();

    _isLoading = true;
    var applicantList = _load();
    applicantList.then((value) {
      ElementList = value;
      for(String x in ElementList){
        x[0].toUpperCase();
      }
      setState(() {
        _isLoading = false;
      });
    });
  }
}
