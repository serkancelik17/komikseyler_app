import 'package:flutter/material.dart';
import 'package:komik_seyler/business/models/abstracts/sectionable.dart';
import 'package:komik_seyler/business/models/abstracts/viewable.dart';

abstract class Repositoriable {
  Future<List<Viewable>> views({@required Sectionable section, int page = 1, int limit = 20});
}
