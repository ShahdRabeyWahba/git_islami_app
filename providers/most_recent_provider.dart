import 'package:flutter/cupertino.dart';
import 'package:islami_app/tabes/quran/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MostRecentProvider extends ChangeNotifier {
  //todo: data
  List<int> mostRecentList = [];

  //todo: get last sura index => read data
  void getLastSuraIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentIndicesAsString =
        prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
    //todo:   List<String> =>   List<int>
    //todo:  ['0','1','2'] => [0,1,2]
    mostRecentList = mostRecentIndicesAsString
        .map((newSuraIndex) => int.parse(newSuraIndex))
        .toList();
    //return mostRecentIndicesAsInt;
    notifyListeners();
  }
}
