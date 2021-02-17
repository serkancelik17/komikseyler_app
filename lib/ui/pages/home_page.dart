import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/category.dart';
import 'package:komik_seyler/ui/templates/home_template.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SectionAbstract> sections = [
      Category(id: 1, name: 'Karikatürler'),
      Category(id: 1, name: 'Karikatürler +18'),
    ];

    return Container(
      child: HomeTemplate(
        sections: sections,
        title: "Komik Şeyler",
      ),
    );
  }
}
