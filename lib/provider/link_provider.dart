import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jupiter_web_app/model/link_model.dart';

import '../helper/db_helper.dart';



class LinkProvider extends ChangeNotifier {

  List<AddLinkModel> linklist=[];
  Future<bool> addlink(AddLinkModel addCartModel) async {
    final rowId = await DBHelper.insertlink(addCartModel);
    if(rowId > 0) {
      addCartModel.id = rowId;
      notifyListeners();
      return true;
    }
    return false;
  }

  getallLinkss() {
    DBHelper.getAllLinks().then((value) {
      linklist = value;
      notifyListeners();
    });
  }


}