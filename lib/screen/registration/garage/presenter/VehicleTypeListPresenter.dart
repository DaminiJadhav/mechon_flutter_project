import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/webService/Repos.dart';

class VehicleTypeListPresenter{

  VehicleTypeListContract _view;
  Repos _repos;

  VehicleTypeListPresenter(this._view){
    _repos= new Injector().mechonRepository;
  }


  void getVehicleTypeList(){
    assert(_view!=null);

    _repos.vehicleTypeList()
        .then((value) => _view.getVehicleTypeListSuccess(value))
        .catchError((onError){
          print(onError);
          _view.getVehicleTypeListError(onError.toString());
    });
  }




}