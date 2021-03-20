
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/request/UserRegistrationRequest.dart';
import 'package:mechon/model/response/UserRegistrationResponse.dart';
import 'package:mechon/screen/registration/user/controller/UserRegistrationController.dart';
import 'package:mechon/screen/registration/user/presenter/UserRegistrationPresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:mechon/utility/Utility.dart';

import '../../login/LoginScreen.dart';

class UserRegistrationScreen extends StatefulWidget {

  String mobileNumber;
  UserRegistrationScreen({this.mobileNumber});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> implements UserRegistrationController {

  TextEditingController firstNameController=new TextEditingController();
  TextEditingController middleNameController=new TextEditingController();
  TextEditingController lastNameController=new TextEditingController();
  TextEditingController emailIdController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController mobileNoController=new TextEditingController();
  TextEditingController dobController=new TextEditingController();

  static String mobileNumber = r'(^[789]\d{9}$)';

  RegExp regexMobile = new RegExp(mobileNumber);

  String date,month,year,selectedDate;
  bool isVisiblePassword=true;


  UserRegistrationPresenter userRegistrationPresenter;
  final formkey = GlobalKey<FormState>();
  bool _isloading = false;



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

  _UserRegistrationScreenState(){
    userRegistrationPresenter=new UserRegistrationPresenter(this);
  }

  @override
  void initState() {
    mobileNoController.text=widget.mobileNumber;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Registration'),
      ),
      // appBar: CurveAppBar.getAppbar("Registration", context),
      body: _userRegistration(),
    );
  }



  Widget _userRegistration(){
    return LoadingOverlay(
      isLoading:_isloading ,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: TextFormField(
                controller: firstNameController,
                enabled: true,
                decoration: InputDecoration(
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
                  labelText: 'First Name',
                  contentPadding: EdgeInsets.only(left: 10.0),

//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                ),
                  validator: (value){
                    if(firstNameController.text.isEmpty){
                      return "Please Enter First Name";
                    }
                  },
                ),
              ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: middleNameController,
                    enabled: true,
                    decoration: InputDecoration(
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
                      labelText: 'Middle Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      /*if(middleNameController.text.isEmpty){
                        return "Please Enter middle Name";
                      }*/
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: lastNameController,
                    enabled: true,
                    decoration: InputDecoration(
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
                      labelText: 'Last Name',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(lastNameController.text.isEmpty){
                        return "Please Enter Last Name";
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
                          color: Colors.red[200],
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )),
                      labelText: 'Email-Id',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(emailIdController.text.isEmpty){
                        return "Please Enter Email-Id";
                      }else if(!EmailValidator.validate(emailIdController.text.trim())){
                        return "Please Enter Valid Email-Id";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: passwordController,
                    enabled: true,
                    obscureText: isVisiblePassword,
                    decoration: InputDecoration(
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
                      labelText: 'Password',
                      contentPadding: EdgeInsets.only(left: 10.0),
                      suffixIcon: IconButton(
                        icon: isVisiblePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isVisiblePassword=!isVisiblePassword;
                          });
                        },
                      ),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(passwordController.text.isEmpty){
                        return "Please Enter Garage Name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: TextFormField(
                    controller: mobileNoController,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                      labelText: 'Mobile Number',
                      contentPadding: EdgeInsets.only(left: 10.0),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: (value){
                      if(mobileNoController.text.isEmpty){
                        return "Please Enter Mobile Number";
                      }else if (!regexMobile.hasMatch(mobileNoController.text)) {
                        return "Please Enter Valid Mobile Number";
                      }
                    },
                  ),

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
                      // Utility.instance.hideKeyboard(context);
                      _selectDate();
                    },
                    validator: (value){
                      if(dobController.text.isEmpty){
                        return "Please Enter DOB";
                      }
                    },
                  ),
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30),
                    child: Text('Registration',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: (){


                    if(formkey.currentState.validate()){
                      setState(() {
                        _isloading=true;
                      });
                      Utility.instance.hideKeyboard(context);
                      _postUserData();
                    }else{
                    }

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


  _postUserData(){
    UserRegistrationRequest userRegistrationRequest=new UserRegistrationRequest();
    userRegistrationRequest.firstName=firstNameController.text.trim();
    userRegistrationRequest.middleName=middleNameController.text.trim();
    userRegistrationRequest.lastName=lastNameController.text.trim();
    userRegistrationRequest.email=emailIdController.text.trim();
    userRegistrationRequest.password=passwordController.text.trim();
    userRegistrationRequest.mobNo=mobileNoController.text.trim();
    userRegistrationRequest.dob=dobController.text.trim();

    userRegistrationPresenter.postUserRegistration(userRegistrationRequest);


  }

  @override
  void postUserRegistrationError(String message) {
    setState(() {
      _isloading=false;
    });
    toast().showToast(message);

  }

  @override
  void postUserRegistrationSuccess(UserRegistrationResponse userRegistrationResponse) {
    setState(() {
      _isloading=false;
    });
    toast().showToast(userRegistrationResponse.message);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()),(r) => false);



  }


}
