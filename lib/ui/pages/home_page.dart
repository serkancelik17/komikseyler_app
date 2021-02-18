import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/business/models/action.dart' as Local;
import 'package:komik_seyler/business/repositories/category_repository.dart';
import 'package:komik_seyler/ui/molecules/text_two_word_color_molecule.dart';
import 'package:komik_seyler/ui/templates/home_template.dart';
import 'package:komik_seyler/ui/themes/custom_colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SectionAbstract> sections = [];
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    getSections;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeTemplate(
        sections: sections,
        title: TextTwoWordColorMolecule(texts: ["Komik", "Şeyler"], colors: [Colors.black, CustomColors.purple], mainAxisAlignment: MainAxisAlignment.center),
      ),
    );
  }

  Future<bool> get getSections async {
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

    setState(() {});

    return true;
  }
}
