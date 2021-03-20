import 'package:mechon/model/response/AddMechanicDetailResponse.dart';
import 'package:mechon/model/response/MechanicUpdateResponse.dart';

abstract class AddMechanicDetailController{

  void postMechanicDetailSuccess(AddMechanicDetailResponse addMechanicDetailResponse);
  void postMechanicDetailError(String message);


  void postUpdatedMechanicSuccess(MechanicUpdateResponse mechanicUpdateResponse);
  void postUpdatedMechanicError(String message);

}
