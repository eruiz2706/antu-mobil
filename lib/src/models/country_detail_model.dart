

class CountryDetail {
  
  String code;
  String name;
  String capitalCity;
  String phoneCode;
  String flag;
  String continentCode;
  String currencyCode;
  List languaje;
  
  CountryDetail({
    this.code,
    this.name,
    this.capitalCity,
    this.phoneCode,
    this.flag,
    this.continentCode,
    this.currencyCode,
    this.languaje
  });

  CountryDetail.fromJsonMap( Map<String, dynamic> json){
    this.code = json['code'];
    this.name = json['name'];
    this.capitalCity = json['capital_city'];
    this.phoneCode = json['phone_code'];
    this.flag = json['flag'];
    this.continentCode = json['continent_code'];
    this.currencyCode = json['currency_code'];
    this.languaje = json['languaje'];
  }
}


