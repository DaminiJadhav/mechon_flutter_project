import 'package:mechon/webService/ApiService.dart';
import 'package:mechon/webService/Repos.dart';

class Injector{

  static final Injector _singleton=new Injector._internal();


  factory Injector(){
     return _singleton;
  }

  Injector._internal();

  Repos get mechonRepository{
    return new ApiService();
  }


}