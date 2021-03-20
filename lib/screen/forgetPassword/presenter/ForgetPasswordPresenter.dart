import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/ForgetPasswordRequest.dart';
import 'package:mechon/screen/forgetPassword/controller/ForgetPasswordController.dart';
import 'package:mechon/webService/Repos.dart';

class ForgetPasswordPresenter {

  ForgetPasswordController _view;
  Repos _repos;

  ForgetPasswordPresenter(this._view) {
    _repos = new Injector().mechonRepository;
  }


  void postForgetPassword(ForgetPasswordRequest forgetPasswordRequest) {
    assert(_view != null);

    _repos
        .forgetPassword(forgetPasswordRequest)
        .then((value) => _view.postForgetPasswordSuccess(value))
        .catchError((onError) {
      print(onError);
      _view.postForgetPasswordError(onError.toString());
    });
  }

}