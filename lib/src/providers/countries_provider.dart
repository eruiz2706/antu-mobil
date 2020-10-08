
import 'dart:async';
import 'dart:convert';
import 'package:antu/src/models/country_detail_model.dart';
import 'package:antu/src/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:antu/src/models/country_model.dart';


class CountriesProvider{

  String _url = new Config().urlBaseApi();

  /*
   * Retorna el listado de paises
  */
  Future<List<Country>> getAll() async{
    final url = Uri.http(_url,'api/countries',{});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Countries.fromJsonList(decodedData['data']['countries']);
    return cast.items;
  }

  /*
   * Retorna la informacion de un pais
  */
  Future<CountryDetail> getDetailByCode(String code) async{
    final url = Uri.http(_url,'api/countries/$code/detail',{});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final country = new CountryDetail.fromJsonMap(decodedData['data']['country']);
    return country;
  }

}