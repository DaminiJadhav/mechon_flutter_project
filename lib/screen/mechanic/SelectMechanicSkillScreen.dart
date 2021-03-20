import 'package:flutter/material.dart';
import 'package:mechon/model/response/GetMechanicSkillResponse.dart';
import 'package:mechon/screen/mechanic/controller/MechanicSkillController.dart';
import 'package:mechon/screen/mechanic/presenter/MechanicSkillPresenter.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/Toast.dart';

class SelectMechanicSkillScreen extends StatefulWidget {
  @override
  _SelectMechanicSkillScreenState createState() => _SelectMechanicSkillScreenState();
}

class _SelectMechanicSkillScreenState extends State<SelectMechanicSkillScreen> implements MechanicSkillController{


  List<bool> _isChecked;
  MechanicSkillPresenter mechanicSkillPresenter;
  List<MechanicSkill> mechanicSkill=new List();

  List<MechanicSkill> selectedmechanicSkill=new List();
  TextEditingController writeIssueController = new TextEditingController();
  bool isOtherSelect=false;


  _SelectMechanicSkillScreenState(){
    mechanicSkillPresenter=new MechanicSkillPresenter(this);
  }


  @override
  void initState() {
    mechanicSkillPresenter.getMechanicSkillList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skills"),
      ),
      body: _getMechanicSkill(),
    );
  }



  Widget _getMechanicSkill() {
    return mechanicSkill.length != 0
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
             children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 25),
                child: Text(
                  'Select Mechanic Skill',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: mechanicSkill.length,
                itemBuilder: (context, int position) {
                  return Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mechanicSkill[position].skillName,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                // checkColor: Colors.blue,
                                value: _isChecked[position],
                                onChanged: (val) {
                                  setState(() {
                                    _isChecked[position] = val;

                                    if (_isChecked[position] == true) {
                                      selectedmechanicSkill
                                          .add(mechanicSkill[position]);

                                      if(mechanicSkill[position].skillName=="Other"){
                                        isOtherSelect=true;
                                      }

                                    } else {
                                      isOtherSelect=false;

                                      selectedmechanicSkill
                                          .remove(mechanicSkill[position]);
                                    }
                                  });
                                }),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 15, right: 15),
                      ),
                      Divider(
                        height: 2,
                      )
                    ],
                  );
                },
              ),
            ),
               isOtherSelect ? Expanded(
                 child: Container(
                   padding: const EdgeInsets.only(bottom: 10.0,top: 6),
                   margin: EdgeInsets.only(left: 20,right: 20),
                   child: TextFormField(
                     controller: writeIssueController,
                     enabled: true,
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(5.0)),
                         borderSide: BorderSide(
                           width: 1,
                           color: MyColors.red[200],
                         ),
                       ),
                       border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                           borderSide: BorderSide(
                             color: MyColors.red,
                           )),
                       labelText: 'Write Your Vehicle Issue',
                       contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                     ),
                   ),
                 ),
               ): Container(
                 child: Text(""),
               ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 40, left: 15, right: 15),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColor),
                child: Text(
                  'Select',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                if(isOtherSelect){
                  if(writeIssueController.text.isEmpty){
                    toast().showToast("Please Write Your Vehicle Issue");
                  }else{
                    Navigator.of(context).pop({"SELECTEDMECHANICSKILL": selectedmechanicSkill,
                      "MechanicSkillText":writeIssueController.text});
                  }
                }else{
                  Navigator.of(context).pop({"SELECTEDMECHANICSKILL": selectedmechanicSkill});
                }


              },
            )
      ],
    )
        : Center(
           child: CircularProgressIndicator(
           backgroundColor: MyColors.red,
      ),
    );
  }

  @override
  void getMechanicSkillError(String message) {
    toast().showToast(message);
  }

  @override
  void getMechanicSkillSuccess(GetMechanicSkillResponse getMechanicSkillResponse) {
    // toast().showToast(getMechanicSkillResponse.message);
    setState(() {
      mechanicSkill=getMechanicSkillResponse.mechanicSkills;
      _isChecked = List<bool>.filled(mechanicSkill.length, false);

    });
  }
}
