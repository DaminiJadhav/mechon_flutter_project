import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/UserRegistrationRequest.dart';
import 'package:mechon/screen/registration/user/controller/UserRegistrationController.dart';
import 'package:mechon/webService/Repos.dart';

class UserRegistrationPresenter{

  UserRegistrationController _view;
  Repos _repos;

  UserRegistrationPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void postUserRegistration(UserRegistrationRequest userRegistrationRequest){
    assert(_view!=null);

    _repos.userRegistration(userRegistrationRequest)
          .then((value) => _view.postUserRegistrationSuccess(value))
          .catchError((onError){
             print(onError);
            _view.postUserRegistrationError(onError.toString());
    });
  }


}