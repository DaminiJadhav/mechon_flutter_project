import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/mechanic/controller/MechnicDetailContract.dart';
import 'package:mechon/webService/Repos.dart';


class MechanicDetailPresenter{

  MechanicDetailController _view;
  Repos _repos;

  MechanicDetailPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void getMechanicDetail(int garageid){
    assert(_view!=null);

    _repos
        .getMechanicDetails(garageid)
        .then((value) => _view.getMechanicDetailSuccess(value))
        .catchError((onError){
      print(onError);
      _view.getMechanicDetailError(onError.toString());
    });

  }

  // void getmechanicList(int garageId){
  //   assert(_view!=null);
  //
  //   _repos
  //       .getMechanicDetails(addMechanicDetailRequest)
  //       .then((value) => _view.postMechanicDetailSuccess(value))
  //       .catchError((onError){
  //     print(onError);
  //     _view.postMechanicDetailError(onError.toString());
  //   });
  //
  // }

}