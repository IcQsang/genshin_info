import 'package:flutter/material.dart';
import 'package:genshin_info/pages/artifactspages/artifactslistpage.dart';
import 'package:genshin_info/pages/characterpages/characterlistpage.dart';
import 'package:genshin_info/pages/elementspages/elementslistpage.dart';
import 'package:genshin_info/pages/nationspages/nationslistpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;
  var _subPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: Text('Genshin Impact'),

    ),drawer: Drawer(
    child: ListView(
    padding: EdgeInsets.zero,
      children: [
        ListTile(
          title: _buildDrawerItem(Icon(Icons.home), 'home'),
          onTap: () => _showSubPage(0),
          selected: _subPageIndex == 0,
        ),
        ListTile(
          title: _buildDrawerItem(Icon(Icons.person), 'Characters'),
          onTap: () => _showSubPage(1),
          selected: _subPageIndex == 1,
        ),
        ListTile(
          title: _buildDrawerItem(Icon(Icons.view_in_ar), 'artifacts'),
          onTap: () => _showSubPage(2),
          selected: _subPageIndex == 2,
        ),
        ListTile(
          title: _buildDrawerItem(Icon(Icons.blur_on), 'elements'),
          onTap: () => _showSubPage(3),
          selected: _subPageIndex == 3,
        ),
        ListTile(
          title: _buildDrawerItem(Icon(Icons.flag), 'nations'),
          onTap: () => _showSubPage(4),
          selected: _subPageIndex == 4,
        ),
      ],

    ),
    ),

      body: _buildSubPage(),);
  }

  _showSubPage(int index) {
    setState(() {
      _subPageIndex = index;
    });
    Navigator.of(context).pop();
  }

  Widget _buildSubPage() {
    switch (_subPageIndex) {
      case 0: // home page
        return Center(
            child: Text(
              'THIS IS A HOME PAGE',
            ));
      case 1:
        return CharacterListPage();
      case 2:
        return ArtifactsListPage();
      case 3:
        return ElementListPage();
      case 4:
        return NationListPage();
      default:
        return SizedBox.shrink();
    }
  }

  Row _buildDrawerItem(Widget icon, String title) {
    return Row(
      children: [
        icon,
        SizedBox(width: 8.0),
        Text(title),
      ],
    );
  }
}
