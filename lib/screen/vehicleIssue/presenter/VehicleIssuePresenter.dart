import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/vehicleIssue/controller/VehicleIssueController.dart';
import 'package:mechon/webService/Repos.dart';

class VehicleIssuePresenter{
  VehicleIssueContract _view;
  Repos _repos;

  VehicleIssuePresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void getVehicleIssue(){
    assert(_view!=null);

    _repos
        .vehicleIssue()
        .then((value) => _view.getVehicleIssueListSuccess(value))
        .catchError((onError){
      print(onError);
      _view.getVehicleIssueListError(onError.toString());
    });

  }

}