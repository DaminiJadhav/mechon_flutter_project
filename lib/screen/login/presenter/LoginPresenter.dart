import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/GarageLoginRequest.dart';
import 'package:mechon/model/request/UserLoginRequest.dart';
import 'package:mechon/model/response/GarageLoginResponse.dart';
import 'package:mechon/screen/login/contoller/LoginController.dart';
import 'package:mechon/webService/Repos.dart';

class LoginPresenter{

  LoginController _view;
  Repos _repos;

  LoginPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void postGarageLogin(GarageLoginRequest garageLoginRequest){
    assert(_view!=null);

    _repos
        .garageLogin(garageLoginRequest)
        .then((value) => _view.postGarageLoginSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postGarageLoginError(onError.toString());
    });

  }


  void postUserLogin(UserLoginRequest userLoginRequest){
    assert(_view!=null);

    _repos
        .userLogin(userLoginRequest)
        .then((value) => _view.postUserLoginSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postUserLoginError(onError.toString());
    });

  }
}
