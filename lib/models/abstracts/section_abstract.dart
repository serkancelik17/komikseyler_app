import 'package:komik_seyler/repositories/abstracts/repository_abstract.dart';

abstract class SectionAbstact {
  int getId();
  String getTitle();
  String getUniqueName();
  RepositoryAbstract getRepository();
}
