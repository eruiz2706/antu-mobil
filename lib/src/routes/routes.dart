
import 'package:antu/src/pages/countries/countries_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'countries': (BuildContext context) => CountriesPage(),
  }; 
}
