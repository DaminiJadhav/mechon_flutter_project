import 'package:mechon/firebase/controller/FirebaseTokenRefreshContract.dart';
import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/FirebaseTokenRefreshRequest.dart';
import 'package:mechon/webService/Repos.dart';

class FirebaseTokenRefreshPresenter{

  FirebaseTokenRefreshContract _view;
  Repos _repos;

  FirebaseTokenRefreshPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void postFirebaseTokenRefresh(FirebaseTokenRefreshRequest firebaseTokenRefreshRequest,int flag){
    assert(_view!=null);

    _repos
        .postFirebaseToken(firebaseTokenRefreshRequest,flag)
        .then((value) => _view.postFirebaseTokenRefreshSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postFirebaseTokenRefreshError(onError.toString());
    });

  }


}
