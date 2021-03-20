import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/AddMechanicDetailRequest.dart';
import 'package:mechon/model/request/MechanicUpdateRequest.dart';
import 'package:mechon/screen/mechanic/controller/AddMechanicDetailContract.dart';
import 'package:mechon/webService/Repos.dart';

class AddMechanicDetailPresenter{

  AddMechanicDetailController _view;
  Repos _repos;

  AddMechanicDetailPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void postMechanicDetail(AddMechanicDetailRequest addMechanicDetailRequest){
    assert(_view!=null);

    _repos
        .postMechanicDetail(addMechanicDetailRequest)
        .then((value) => _view.postMechanicDetailSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postMechanicDetailError(onError.toString());
    });

  }


  void postupdatedMechanicDetail(AddMechanicDetailRequest addMechanicDetailRequest){
    assert(_view!=null);

    _repos
        .postUpdatedMechanic(addMechanicDetailRequest)
        .then((value) => _view.postUpdatedMechanicSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postUpdatedMechanicError(onError.toString());
    });

  }


}