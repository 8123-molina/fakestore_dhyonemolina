import 'dart:convert';
import 'dart:developer';

import '../../data/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritsController {
  // Reatividade loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final prefs = SharedPreferences.getInstance();

  // Reatividade stateFavorits
  final ValueNotifier<List<dynamic>> stateFavorits =
      ValueNotifier<List<dynamic>>([]);

  // Reatividade erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  // Seção de preferences
  static const String _key = "key";

  // Salvando elemento a list da favoritos
  save(String id) async {
    final prefs = await SharedPreferences.getInstance();
    stateFavorits.value.add(jsonEncode(id));

    prefs.setString('favorits', stateFavorits.value.toString());
  }

  read(String id) async {
    final prefs = await SharedPreferences.getInstance();

    String? stringKey = prefs.getString(_key);
    return json.decode(stringKey!);
  }

  remove(String id) async {
    final prefs = await SharedPreferences.getInstance();
    // int idI = int.parse(id);
    // var listFavorits = prefs.getString('favorits');

    // if (listFavorits != null) {
    //   List<dynamic> lis = jsonDecode(listFavorits).toList();

    //   lis.remove(idI.toString());

    //   prefs.setString('favorits', lis.toString());
    //   log(stateFavorits.value.toString());
    // }
  }

  Future<List<dynamic>> isFavorits() async {
    final prefs = await SharedPreferences.getInstance();
    var favorites = prefs.getString('favorits');

    String a = '${favorites}';
    List<dynamic> listFavorits = json.decode(a).cast<String>().toList();

    return listFavorits;
  }

  Future getFavorits() async {
    isLoading.value = true;

    try {
      List<dynamic> result = await isFavorits();
      log(stateFavorits.value.toString());
      log(result.toString());
      return stateFavorits.value = result;
    } on NotfoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
