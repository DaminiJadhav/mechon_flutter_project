import 'package:mechon/injection/Injector.dart';
import 'package:mechon/screen/mechanic/controller/MechanicSkillController.dart';
import 'package:mechon/webService/Repos.dart';

class MechanicSkillPresenter{

  MechanicSkillController _view;
  Repos _repos;

  MechanicSkillPresenter(this._view){
    _repos=new Injector().mechonRepository;
  }


  void getMechanicSkillList(){
    assert(_view!=null);

    _repos
        .getMechanicSkill()
        .then((value) => _view.getMechanicSkillSuccess(value))
        .catchError((onError){
      print(onError);
      _view.getMechanicSkillError(onError.toString());
    });

  }

}