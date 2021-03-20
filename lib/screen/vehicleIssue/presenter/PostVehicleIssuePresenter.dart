import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/PostVehicleIssueRequest.dart';
import 'package:mechon/screen/vehicleIssue/controller/PostVehicleIssueContract.dart';
import 'package:mechon/webService/Repos.dart';

class PostVehicleIssuePresenter{
  PostVehicleIssueContract _view;
  Repos _repos;

  PostVehicleIssuePresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void postVehicleIssue(PostVehicleIssueRequest postVehicleIssueRequest){
    assert(_view!=null);

    _repos
        .postvehicleIssue(postVehicleIssueRequest)
        .then((value) => _view.postVehicleIssueSuccess(value))
        .catchError((onError){
      print(onError);
      _view.postVehicleIssueError(onError.toString());
    });

  }

}