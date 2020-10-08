import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:antu/src/routes/routes.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Antu',
      debugShowCheckedModeBanner: false,
      initialRoute: 'countries',
      routes: getApplicationRoutes(),
    );
  }
}