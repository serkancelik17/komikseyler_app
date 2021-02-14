import 'package:komik_seyler/repositories/repository.dart';

abstract class Section {
  int getId();
  String getTitle();
  String getUniqueName();
  Repository getRepository();
}
