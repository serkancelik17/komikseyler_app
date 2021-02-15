import 'package:flutter/material.dart';
import 'package:komik_seyler/models/abstracts/section_abstract.dart';
import 'package:komik_seyler/models/abstracts/view_abstract.dart';

abstract class RepositoryAbstract {
  Future<List<ViewAbstract>> views({@required SectionAbstract section, int page = 1, int limit = 20});
}
