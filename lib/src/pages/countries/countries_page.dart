import 'package:antu/src/models/country_detail_model.dart';
import 'package:antu/src/models/country_model.dart';
import 'package:antu/src/providers/countries_provider.dart';
import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final CountriesProvider countriesProvider = new CountriesProvider();
  Future<List> listCountries;
  
  @override
  void initState() {
    super.initState();
    listCountries = countriesProvider.getAll();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Stack(
        children: [
          _buildImage(),
          Container(
            padding: EdgeInsets.only(top:147),
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Countries',style: TextStyle(fontSize:28,color: Colors.white,fontWeight: FontWeight.w900))
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0)
                      ),
                      color: Color(0xFFFAFAFA),
                    ),
                    child: SizedBox(),
                  )
                ],
              ),
              Expanded(
                child: _countries(),
              )
            ]),
          ),
          Positioned(
            top: 155,
            right: 40,
            child: InkWell(
              onTap: () {
                setState(() {
                  listCountries = countriesProvider.getAll();
                });
              },
              child: Container(
                width: 60,
                height: 60,
                child: Icon(Icons.replay_outlined, size: 30,color: Colors.white,),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[600]
                )
              ),
            ),
          )
      ],)
    );
  }

  Widget _buildImage(){
    return Container(
      width: double.infinity,
      height: 200,
      child: FadeInImage(
        image: NetworkImage('https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
        placeholder: AssetImage('assets/images/jar-loading.gif'),
        fadeInDuration: Duration(milliseconds: 15),
        fit: BoxFit.fill,
      )
    ); 
  }

  Widget _countries() {
    return FutureBuilder(
        future: listCountries,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List<Country> data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return _itemCountry(context,data[index]);
                },
              );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _itemCountry(BuildContext context,Country country) {
    return InkWell(
      onTap: (){
        _detailCountry(context,country.code);
      },
      child: ListTile(
        title: Text(country.code),
        subtitle: Text(country.name),
        trailing: Icon(Icons.arrow_forward_rounded),
      )
    );
  }

  void _detailCountry (context,String code) async{
    CountryDetail countryDetail = await countriesProvider.getDetailByCode(code);
    List<Widget> lista = new List<Widget>();
    List languaje = countryDetail.languaje;

    if(!languaje.isEmpty){
      lista.add(Container(
        padding: EdgeInsets.only(top:10.0),
        child: Text('Languaje',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w900),)
      ));

      for(int i=0;i<languaje.length;i++){
        lista.add(
          Text('${languaje[i]['sISOCode']} (${languaje[i]['sName']})'),
        );
      }
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            padding: EdgeInsets.all(15.0),
            child:  Wrap(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Code',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.code}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.name}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Capital City',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.capitalCity}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phone Code',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.phoneCode}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Continent Code',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.continentCode}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Currency Code',style: TextStyle(fontWeight: FontWeight.w900),),
                  Text('${countryDetail.currencyCode}')
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Flag',style: TextStyle(fontWeight: FontWeight.w900),),
                  FadeInImage(
                    image: NetworkImage('${countryDetail.flag}'),
                    placeholder: AssetImage('assets/images/jar-loading.gif'),
                    fadeInDuration: Duration(milliseconds: 15),
                    fit: BoxFit.fill,
                    width: 50,
                    height: 30,
                  )
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lista
              )
            ],
          ),
          );
      }
    );
  }
}