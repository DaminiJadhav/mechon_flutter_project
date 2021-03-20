import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/map/neargaragelocations/controller/NearByGarageLocationContract.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/webService/Repos.dart';

class NearByGarageLocationPresenter{

  NearByGarageLocationContract _view;
  Repos _repos;

  NearByGarageLocationPresenter(this._view){
    _repos= new Injector().mechonRepository;
  }


  void getNearByGarageLocationList(int vehicleTypeId,double userLat,double userLog){
    assert(_view!=null);

    _repos.getNearByGarageLocationList(vehicleTypeId, userLat, userLog)
        .then((value) => _view.getNearByGarageLocationSucess(value))
        .catchError((onError){
      print(onError);
      _view.getNearByGarageLocationSError(onError.toString());
    });
  }




}