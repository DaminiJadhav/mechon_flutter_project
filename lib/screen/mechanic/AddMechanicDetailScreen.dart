import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/firebase/PushNotificationsManager.dart';
import 'package:mechon/model/request/AddMechanicDetailRequest.dart';
import 'package:mechon/model/request/MechanicUpdateRequest.dart';
import 'package:mechon/model/response/AddMechanicDetailResponse.dart';
import 'package:mechon/model/response/GetMechanicDetailResponse.dart';
import 'package:mechon/model/response/GetMechanicSkillResponse.dart';
import 'package:mechon/model/response/MechanicUpdateResponse.dart';
import 'package:mechon/screen/mechanic/MechanicDetailScreen.dart';
import 'package:mechon/screen/mechanic/SelectMechanicSkillScreen.dart';
import 'package:mechon/screen/mechanic/controller/AddMechanicDetailContract.dart';
import 'package:mechon/screen/mechanic/controller/MechnicDetailContract.dart';
import 'package:mechon/screen/mechanic/presenter/AddMechanicDetailPresenter.dart';
import 'package:mechon/screen/mechanic/presenter/MechanicDetailPresenter.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class AddMechanicDetailScreen extends StatefulWidget {

  String mechanicDetail;
  int mechanicId;
  MechanicDetail mechanicDetailPosition;
  AddMechanicDetailScreen({this.mechanicDetail,this.mechanicId,this.mechanicDetailPosition});

  @override
  _AddMechanicDetailScreenState createState() => _AddMechanicDetailScreenState();
}

class _AddMechanicDetailScreenState extends State<AddMechanicDetailScreen> implements AddMechanicDetailController{

  TextEditingController mechanicFirstNameController=new TextEditingController();
  TextEditingController mechanicMiddleNameController=new TextEditingController();
  TextEditingController mechanicLastNameController=new TextEditingController();
  TextEditingController mobileNumberController=new TextEditingController();
  TextEditingController emailIdController=new TextEditingController();
  TextEditingController skillController=new TextEditingController();
  TextEditingController addressController=new TextEditingController();
  TextEditingController dobController=new TextEditingController();

  static String mobileNumber = r'(^[789]\d{9}$)';
  RegExp regexMobile = new RegExp(mobileNumber);
  String otherIssue;
  final formkey = GlobalKey<FormState>();
  bool isloading = false;

  List<MechanicSkill> selectedMechanicSkill=new List();
  String date,month,year,selectedDate;

  AddMechanicDetailPresenter _addMechanicDetailPresenter;


  _AddMechanicDetailScreenState(){
    _addMechanicDetailPresenter=new AddMechanicDetailPresenter(this);

  }


  Future _selectDate() async{
    FocusScope.of(context)
        .requestFocus(FocusNode());
    DateTime picked=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: new DateTime.now());

    if(picked!=null){
      setState(() {
        date=picked.day.toString();
        month=picked.month.toString();
        year=picked.year.toString();

        selectedDate=date+"-"+month+"-"+year;
        dobController.text=selectedDate;
      });
    }
  }


  @override
  void initState() {
    _mechanicdetailset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic'),
      ),
      body: _mechanicDetails(),
    );
  }

  Widget _mechanicDetails(){
    return LoadingOverlay(
      isLoading: isloading,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mechanicFirstNameController,
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
                      labelText: 'First Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(mechanicFirstNameController.text.isEmpty){
                        return "Please Enter First Name";
                      }
                    },
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mechanicMiddleNameController,
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
                      labelText: 'Middle Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mechanicLastNameController,
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
                      labelText: 'Last Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(mechanicLastNameController.text.isEmpty){
                        return "Please Enter Last Name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mobileNumberController,
                    enabled: true,
                    // maxLength: 10,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Mobile Number',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(mobileNumberController.text.isEmpty){
                        return "Please Enter Mobile Number";
                      }else if (!regexMobile.hasMatch(mobileNumberController.text)) {
                        return "Please Enter Valid Mobile Number";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: emailIdController,
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
                      labelText: 'Email-Id',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      // if(emailIdController.text.isEmpty){
                      //   return "Please Enter Email-Id";
                      // }else
                      if(emailIdController.text.isNotEmpty){
                        if(!EmailValidator.validate(emailIdController.text.trim())){
                          return "Please Enter Valid Email-Id";
                        }
                      }

                    },
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _displayMechanicSkill(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyColors.red[200]
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.only(left: 4),
                            child: Text('Select Mechanic Skill'),
                          ),
                          //  Select Your Garage Type
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Container(
                                child: Text('Choose'),
                                margin: EdgeInsets.only(right: 5),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                            ],

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(selectedMechanicSkill.length!=0)  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedMechanicSkill.length,
                    itemBuilder: (context,int index){
                      return Container(
                        child:Text(selectedMechanicSkill[index].skillName,style: TextStyle(fontSize: 16),),
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: dobController,
                    enabled: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.date_range),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.red[200],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )),
                      labelText: 'DOB',
                      contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    maxLines: 1,
                    onTap: (){
                      _selectDate();
                    },
                    validator: (value){
                      if(dobController.text.isEmpty){
                        return "Please Enter DOB ";
                      }
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30),
                    child: Text('Add',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: (){
                    _postMechanicDetail();

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));
                    // Navigator.pop(context)  ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future _displayMechanicSkill(BuildContext context) async {
  //   var results=await Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => SelectMechanicSkillScreen()));
  //
  //   if (results != null && results.containsKey('SELECTEDMECHANICSKILL')) {
  //     setState(() {
  //       try {
  //         selectedMechanicSkill = results["SELECTEDMECHANICSKILL"];
  //         print("Select Mechanic Skill ${selectedMechanicSkill}");
  //
  //       }on Exception catch (exception){
  //         print(exception);
  //       };
  //
  //     });
  //   }
  //
  // }


  Future _displayMechanicSkill(BuildContext context) async {
    var results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SelectMechanicSkillScreen();
    }));


    if (results != null && results.containsKey('SELECTEDMECHANICSKILL')) {
      setState(() {
        try {
          selectedMechanicSkill = results["SELECTEDMECHANICSKILL"];
          print(selectedMechanicSkill);

        }on Exception catch (exception){
          print(exception);
        };

      });
    }
    if (results != null && results.containsKey('MechanicSkillText')) {
      setState(() {
        otherIssue=results['MechanicSkillText'];
        print(otherIssue);

      });
    }

  }


  _postMechanicDetail(){
    if(formkey.currentState.validate()){

      if(selectedMechanicSkill.length==0){
        toast().showToast("Please Select Mechanic Skill");
      }else{
        setState(() {
          isloading=true;
        });

        _postMechanicDetails();
      }



      // toast().showToast("success");
    }else{
      // toast().showToast("error");

    }
  }



  _postMechanicDetails(){


    List<MechanicDetailSkillSet> mechanicList=new List();

    for(int i=0;i<selectedMechanicSkill.length;i++){
      MechanicDetailSkillSet mechanicDetailSkillSet=new MechanicDetailSkillSet();

      mechanicDetailSkillSet.skillsetId=selectedMechanicSkill[i].skillsetId;
      mechanicDetailSkillSet.skillName=selectedMechanicSkill[i].skillName;

      mechanicList.add(mechanicDetailSkillSet);
    }


    if(widget.mechanicDetail=="AddMechanic") {


      AddMechanicDetailRequest addMechanicDetailRequest = new AddMechanicDetailRequest();
      addMechanicDetailRequest.mechanicId = "";
      addMechanicDetailRequest.garageid =
          int.parse(SessionManager.getGarageId());
      addMechanicDetailRequest.firstname = mechanicFirstNameController.text;
      addMechanicDetailRequest.middlename = mechanicMiddleNameController.text;
      addMechanicDetailRequest.lastname = mechanicLastNameController.text;
      addMechanicDetailRequest.emailid = emailIdController.text;
      addMechanicDetailRequest.dob = dobController.text;
      addMechanicDetailRequest.mobNo = mobileNumberController.text;
      addMechanicDetailRequest.imageName = "";
      addMechanicDetailRequest.imagePath = "";
      addMechanicDetailRequest.other = otherIssue;
      addMechanicDetailRequest.mechanicAndSkillMappingId = 0;
      addMechanicDetailRequest.mechanicSkillSet = mechanicList;

      print("Add Mechanic" +widget.mechanicId.toString());
      _addMechanicDetailPresenter.postMechanicDetail(addMechanicDetailRequest);


    }else{
      AddMechanicDetailRequest addMechanicDetailRequest = new AddMechanicDetailRequest();
      addMechanicDetailRequest.mechanicId = widget.mechanicId;
      addMechanicDetailRequest.garageid =
          int.parse(SessionManager.getGarageId());
      addMechanicDetailRequest.firstname = mechanicFirstNameController.text;
      addMechanicDetailRequest.middlename = mechanicMiddleNameController.text;
      addMechanicDetailRequest.lastname = mechanicLastNameController.text;
      addMechanicDetailRequest.emailid = emailIdController.text;
      addMechanicDetailRequest.dob = dobController.text;
      addMechanicDetailRequest.mobNo = mobileNumberController.text;
      addMechanicDetailRequest.imageName = "";
      addMechanicDetailRequest.imagePath = "";
      addMechanicDetailRequest.other = otherIssue;
      addMechanicDetailRequest.mechanicAndSkillMappingId = 0;
      addMechanicDetailRequest.mechanicSkillSet = mechanicList;

      print("Update Mechanic" + widget.mechanicId.toString());
      _addMechanicDetailPresenter.postupdatedMechanicDetail(addMechanicDetailRequest);

    }

  }


  _mechanicdetailset(){
    if(widget.mechanicDetail=="UpdateMechanic"){
      // toast().showToast(widget.mechanicDetailPosition.firstName);

      mechanicFirstNameController.text=widget.mechanicDetailPosition.firstName;
      mechanicMiddleNameController.text=widget.mechanicDetailPosition.middleName;
      mechanicLastNameController.text=widget.mechanicDetailPosition.lastName;
      mobileNumberController.text=widget.mechanicDetailPosition.mobNo;
      emailIdController.text=widget.mechanicDetailPosition.email;



      if(widget.mechanicDetailPosition.dob!=null){
        date=widget.mechanicDetailPosition.dob.day.toString();
        month=widget.mechanicDetailPosition.dob.month.toString();
        year=widget.mechanicDetailPosition.dob.year.toString();

        selectedDate=date+"-"+month+"-"+year;
        dobController.text=selectedDate;
      }



    }
  }

  @override
  void postMechanicDetailError(String message) {
    setState(() {
      isloading=false;
    });
    toast().showToast("Something Went Wrong");
  }

  @override
  void postMechanicDetailSuccess(AddMechanicDetailResponse addMechanicDetailResponse) {
    setState(() {
      isloading=false;
    });
    toast().showToast(addMechanicDetailResponse.message);
    Navigator.of(context).pop({"MECHANICDETAILS": "mechanicDetails"});

    // Navigator.of(context).popUntil(ModalRoute.withName('/MechanicDetail'));

  }

  @override
  void postUpdatedMechanicError(String message) {
    setState(() {
      isloading=false;
    });
    // toast().showToast("Something Went Wrong");

  }

  @override
  void postUpdatedMechanicSuccess(MechanicUpdateResponse mechanicUpdateResponse) {
    setState(() {
      isloading=false;
    });
    toast().showToast(mechanicUpdateResponse.message);

    Navigator.of(context).pop({"MECHANICDETAILS": "mechanicDetails"});


  }



}
