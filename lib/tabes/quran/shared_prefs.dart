import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKey {
  static const String mostRecentKey = 'most_recent';
}

//todo: save last sura index => write data
//todo: save last sura index => write data
void saveLastSuraIndex(int newSuraIndex) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //todo: get list sura index from shared prefs
  List<String> mostRecentList =
      prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
  //todo: check index => exist => remove => add
  if (mostRecentList.contains('$newSuraIndex')) {
    mostRecentList.remove('$newSuraIndex');
    mostRecentList.insert(0, '$newSuraIndex');
  } else {
    //todo: check index => not exist => add
    mostRecentList.insert(0, '$newSuraIndex');
  }
  //todo: limit
  if (mostRecentList.length > 5) {
    mostRecentList.removeLast();
  }
  await prefs.setStringList(SharedPrefsKey.mostRecentKey, mostRecentList);
}

Future<List<int>> getLastSuraIndex() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> mostRecentList =
      prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
  return mostRecentList.map((e) => int.parse(e)).toList();
}
