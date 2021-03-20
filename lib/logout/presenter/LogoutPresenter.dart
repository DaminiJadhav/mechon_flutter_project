




import 'package:mechon/injection/Injector.dart';
import 'package:mechon/logout/controller/LogoutController.dart';
import 'package:mechon/webService/Repos.dart';

class LogoutPresenter {

  LogoutController _view;
  Repos _repos;

  LogoutPresenter(this._view) {
    _repos = new Injector().mechonRepository;
  }


  void logout(int flag,String id) {
    assert(_view != null);

    _repos.
      postLogout(flag,id)
        .then((value) => _view.logoutSuccess(value))
        .catchError((onError) {
      print(onError);
      _view.logoutError(onError.toString());
    });
  }
}