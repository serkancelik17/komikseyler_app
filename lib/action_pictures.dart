import 'package:flutter/material.dart';
import 'package:komik_seyler/models/action.dart' as Local;
import 'package:komik_seyler/models/picture.dart';
import 'package:komik_seyler/partials/bottomBar.dart';
import 'package:komik_seyler/repositories/action_repository.dart';

import './cards.dart';
import './matches.dart';

class ActionPictures extends StatefulWidget {
  final Local.Action action;
  MatchEngine matchEngine;

  ActionPictures({
    this.action,
    Key key,
  }) : super(key: key) {
    matchEngine = new MatchEngine();
  }

  @override
  _ActionPicturesState createState() => _ActionPicturesState();
}

class _ActionPicturesState extends State<ActionPictures> {
  Match match = new Match();
  ActionRepository _actionRepository = ActionRepository();
  final pageTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.action.title),
      ),
      body: (widget.matchEngine.matches.length == 0) ? Center(child: Text("Yükleniyor...")) : new CardStack(matchEngine: widget.matchEngine, categoryId: widget.action.id, parent: this),
      bottomNavigationBar: (widget.matchEngine.matches.length != 0) ? BottomBar(context: context, currentMatch: widget.matchEngine.currentMatch) : null,
    );
  }

  Future<void> getInit() async {
    List<Picture> _pictures = await _actionRepository.pictures(action: widget.action, page: 1);
    setState(() {
      widget.matchEngine.matches = [];
      widget.matchEngine.matches.addAll(_pictures.map((Picture picture) => Match(picture: picture)));
    });
  }
}
