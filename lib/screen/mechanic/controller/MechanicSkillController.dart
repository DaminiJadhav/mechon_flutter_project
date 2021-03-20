
import 'package:mechon/model/response/GetMechanicSkillResponse.dart';

abstract class MechanicSkillController{

  void getMechanicSkillSuccess(GetMechanicSkillResponse getMechanicSkillResponse);
  void getMechanicSkillError(String message);

  }
