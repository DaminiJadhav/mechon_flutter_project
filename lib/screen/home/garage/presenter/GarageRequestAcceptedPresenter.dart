import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/home/garage/controller/GarageRequestAcceptedContract.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/webService/Repos.dart';

class GarageRequestAcceptedPresenter{

  GarageRequestAcceptedContract _view;
  Repos _repos;

  GarageRequestAcceptedPresenter(this._view){
    _repos= new Injector().mechonRepository;
  }


  void getGarageUserIssueDetail(String garageId){
    assert(_view!=null);

    _repos.getGarageUserIssueDetail(garageId)
        .then((value) => _view.getGarageUserIssueRequestDetailSuccess(value))
        .catchError((onError){
      print(onError);
      _view.getGarageUserIssueRequestDetailError(onError.toString());
    });
  }




}