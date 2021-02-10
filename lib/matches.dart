import 'package:flutter/widgets.dart';
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/models/response.dart';
import 'package:komik_seyler/repositories/picture_repository.dart';

class MatchEngine extends ChangeNotifier {
  List<Match> _matches = [];
  int currentMatchIndex;
  int nextMatchIndex;
  int prevMatchIndex;

  List<Match> get matches => _matches;

  set matches(List<Match> value) {
    _matches = value;
  }

  MatchEngine({List<Match> matches}) : _matches = matches {
    _matches ??= [];
    currentMatchIndex = 0;
    nextMatchIndex = 1;
  }

  Match get currentMatch => _matches[currentMatchIndex];
  Match get nextMatch => _matches[nextMatchIndex];

  void cycleMatch() {
    print("Decision: " + currentMatch.decision.toString());
    print("Matches Length: " + _matches.length.toString());

    if (currentMatch.decision != Decision.indecided) {
      currentMatch.reset();
      if (nextMatchIndex < _matches.length - 1) {
        prevMatchIndex = currentMatchIndex - 1;
        currentMatchIndex = nextMatchIndex;
        nextMatchIndex = nextMatchIndex + 1;
      } else {
        throw Exception('Bitti');
      }
    } else {
      if (currentMatchIndex > 1) {
        nextMatchIndex = currentMatchIndex;
        currentMatchIndex = prevMatchIndex;
        if (currentMatchIndex > 0)
          prevMatchIndex = prevMatchIndex - 1;
        else
          prevMatchIndex = 0;
      }
    }
    notifyListeners();
  }
}

class Match extends ChangeNotifier {
  final Picture picture;
  final PictureRepository _pictureRepository = PictureRepository();

  Decision decision = Decision.indecided;

  Match({this.picture});

  void nope() {
    if (decision == Decision.indecided) {
      decision = Decision.nope;
      notifyListeners();
    }
  }

  Future<bool> destroy() async {
    try {
      bool result = await _pictureRepository.destroy(pictureId: picture.id);
      return result;
    } catch (e) {
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<Response> addAction({@required actionName, @required bool value}) async {
    Response response = await _pictureRepository.addAction(actionName: actionName, pictureId: picture.id, value: value);
    return response;

    /*  if (decision == Decision.favorite) {
      decision = Decision.favorite;
      notifyListeners();
    }*/
  }

  void reset() {
    if (decision != Decision.indecided) {
      decision = Decision.indecided;
      notifyListeners();
    }
  }
}

enum Decision {
  indecided,
  nope,
  like,
  favorite,
}
