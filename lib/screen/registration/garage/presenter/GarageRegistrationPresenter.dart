import 'package:mechon/injection/Injector.dart';
import 'package:mechon/model/request/GarageRegistrationRequest.dart';
import 'package:mechon/screen/registration/garage/controller/GarageRegistrationContract.dart';
import 'package:mechon/webService/Repos.dart';

class GarageRegistrationPresenter{
   GarageRegistrationContract _view;
   Repos _repos;

   GarageRegistrationPresenter(this._view){
      _repos=new Injector().mechonRepository;
   }


   void postGarageRegistration(GarageRegistrationRequest garageRegistrationRequest){
      assert(_view!=null);

      _repos
          .garageRegistration(garageRegistrationRequest)
          .then((value) => _view.postGarageRegistrationSuccess(value))
          .catchError((onError){
             print(onError);
             _view.postGarageRegistrationError(onError.toString());
      });

   }


}