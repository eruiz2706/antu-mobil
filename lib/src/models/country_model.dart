
class Countries {

  List<Country> items = new List();

  Countries();

  Countries.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    jsonList.forEach((item) {
      final country = new Country.fromJsonMap(item);
      items.add( country );
    });

  }

}

class Country {
  int id;
  String code;
  String name;
  
  Country({
    this.id,
    this.code,
    this.name
  });

  Country.fromJsonMap( Map<String, dynamic> json){
    this.id = json['id'];
    this.code = json['code'];
    this.name = json['name'];
  }
}


