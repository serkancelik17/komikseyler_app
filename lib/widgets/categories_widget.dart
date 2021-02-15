import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/repositories/action_repository.dart';
import 'package:komik_seyler/repositories/category_repository.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSections(),
        builder: (context, AsyncSnapshot<List<SectionAbstract>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (SectionAbstract section in snapshot.data)
                  InkWell(
                    child: ListTile(
                      leading: getFaIcon(section),
                      title: Text(section.getTitle()),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                      contentPadding: EdgeInsets.all(5),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/categories',
                        arguments: section),
                  )
              ],
            );
/*
            return Column(
              children: [
                for (Category category in snapshot.data)
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      color: Colors.blue.shade300,
                      //onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Pictures(section: category))),
                      onPressed: () => Navigator.pushNamed(context, '/categories', arguments: category),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 13,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            category.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.green,
                    onPressed: () async {
                      Local.Action _action = await getAction(actionName: 'like');
                      //return CupertinoPageRoute(builder: (_) => PicturesPage(section: _action);
                      return Navigator.pushNamed(context, '/categories', arguments: _action);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 13,
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite, color: Colors.white),
                                Text(
                                  " Beğendiklerim",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    color: Colors.blue,
                    onPressed: () async {
                      Local.Action _action = await getAction(actionName: 'favorite');
                      return Navigator.pushNamed(context, '/categories', arguments: _action);
                      //return Navigator.push(context, MaterialPageRoute(builder: (context) => Pictures(section: _action)));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 13,
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.white),
                                Text(
                                  "Favorilerim",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),
                  ),
                )
              ],
            );
*/
          } else {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  Future<List<SectionAbstract>> getSections() async {
    List<SectionAbstract> sections = [];
    CategoryRepository catRepo = CategoryRepository();
    //  try {
    List<SectionAbstract> categories = await catRepo.getCategories();
    sections.addAll(categories);
/*    } catch (error) {
      Navigator.pushNamed(context, '/error', arguments: error);
    }*/

    List<SectionAbstract> additionalSections = [
      Local.Action(name: "like", title: "Beğendiklerim", id: 1),
      Local.Action(name: "favorite", title: "Favorilerim", id: 2),
    ];

    sections.addAll(additionalSections);

    return sections;
  }

  Future<Local.Action> getAction({@required actionName}) async {
    ActionRepository _actionRepository = ActionRepository();
    return await _actionRepository.getAction(actionName: actionName);
  }

  FaIcon getFaIcon(SectionAbstract section) {
    Map<String, dynamic> sectionImgMap = {
      'category1': {'icon': FontAwesomeIcons.comments},
      'category2': {'icon': FontAwesomeIcons.venusMars}, //+18
      'category3': {'icon': FontAwesomeIcons.images},
      'category4': {'icon': FontAwesomeIcons.camera},
      'category5': {'icon': FontAwesomeIcons.film},
      'category6': {'icon': FontAwesomeIcons.laughSquint},
      'action1': {'icon': FontAwesomeIcons.heart, 'color': Colors.red},
      'action2': {'icon': FontAwesomeIcons.star, 'color': Colors.blue},
    };
    return FaIcon(
        sectionImgMap[section.getUniqueName()]['icon'] ??
            FontAwesomeIcons.folderOpen,
        size: 30,
        color: sectionImgMap[section.getUniqueName()]['color'] ?? null);
  }
}
