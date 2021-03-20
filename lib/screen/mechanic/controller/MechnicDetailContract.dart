import 'package:mechon/model/response/GetMechanicDetailResponse.dart';

abstract class MechanicDetailController{

  void getMechanicDetailSuccess(GetMechanicDetailResponse getMechanicDetailResponse);
  void getMechanicDetailError(String message);

}
