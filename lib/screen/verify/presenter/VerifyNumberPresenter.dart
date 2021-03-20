import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/verify/controller/VerifyNumberContract.dart';
import 'package:mechon/webService/Repos.dart';

class VerifyNumberPresenter{

  VerifyNumberContract _view;
  Repos repos;

  VerifyNumberPresenter(this._view){
    repos=new Injector().mechonRepository;
  }


  void verifyNumber(String mobile,String email,int flag,int roleflag){
    assert(_view!=null);

    repos.verifyNumber(mobile, email, flag, roleflag)
       .then((value) => _view.verifyNumberSuccess(value))
       .catchError((onError){
       print(onError);
         _view.verifyNumberError(onError.toString());
    });

  }


}