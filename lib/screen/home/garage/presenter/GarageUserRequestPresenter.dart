
import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/GarageRequestAcceptRequest.dart';
import 'package:mechon/model/request/RejectUserRequestModel.dart';
import 'package:mechon/screen/home/garage/controller/GarageUserRequestContract.dart';
import 'package:mechon/webService/Repos.dart';

class GarageUserRequestPresenter{

  GarageUserRequestContract _view;
  Repos _repos;

  GarageUserRequestPresenter(this._view){
    _repos= new Injector().mechonRepository;
  }


  void postGarageAcceptRequest(GarageRequestAcceptRequest garageRequestAcceptRequest){
    assert(_view!=null);

    _repos.postGarageRequestAccept(garageRequestAcceptRequest)
        .then((value) => _view.postGarageAcceptRequestSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postGarageAcceptRequestError(onError.toString());
    });
  }


  void postGarageUserRejectRequest(RejectUserRequestModel rejectUserRequestModel){
    assert(_view!=null);

    _repos.postUserRequestReject(rejectUserRequestModel)
        .then((value) => _view.postGarageUserRejectRequestSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postGarageUserRejectRequestError(onError.toString());
    });
  }


  void getCurrentUserGarageRequest(int garageid){
    assert(_view!=null);

    _repos.getCurentGarageUserRequest(garageid)
        .then((value) => _view.getGarageUserRequestSuccess(value))
        .catchError((onError){
      print(onError);
      _view.getGarageUserRequestError(onError.toString());
    });
  }


}