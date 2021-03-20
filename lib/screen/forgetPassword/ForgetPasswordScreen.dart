import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/request/ForgetPasswordRequest.dart';
import 'package:mechon/model/response/ForgetPasswordResponse.dart';
import 'package:mechon/screen/forgetPassword/controller/ForgetPasswordController.dart';
import 'package:mechon/screen/forgetPassword/presenter/ForgetPasswordPresenter.dart';
import 'package:mechon/screen/login/LoginScreen.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:mechon/utility/Utility.dart';

class ForgetPasswordScreen extends StatefulWidget {
  String mobileNumber;
  ForgetPasswordScreen({this.mobileNumber});
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> implements ForgetPasswordController{

  TextEditingController newPasswordController=new TextEditingController();
  TextEditingController confirmPasswordController=new TextEditingController();

  bool isloading = false;
  bool isVisiblePassword=true;
  bool isVisibleConfirmPassword=true;



  final formkey = GlobalKey<FormState>();
  ForgetPasswordPresenter _forgetPasswordPresenter;

  _ForgetPasswordScreenState(){
    _forgetPasswordPresenter=new ForgetPasswordPresenter(this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      // appBar: CurveAppBar.getAppbar("Dashboard", context),
      body: _forgetPasswordTextField(),
    );
  }


  Widget _forgetPasswordTextField(){
    return Center(
        child: LoadingOverlay(
          isLoading: isloading,
          opacity: 0.5,
          color: Colors.white,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: MyColors.red,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Container(
                margin: EdgeInsets.only(left: 25,right: 25,top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    alignment: Alignment.centerRight,
                   child: Text('Minimum 6 character'),
                   ),
                 Padding(
                  padding: const EdgeInsets.only(bottom:10.0,top: 6),
                  child: TextFormField(
                    controller: newPasswordController,
                    enabled: true,
                    obscureText: isVisiblePassword ,
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
                      labelText: 'New Password',
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
                    validator: forgetPasswordlengthvalidate,

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.centerRight,
                  child: Text('Minimum 6 character',),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0,top: 6),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    enabled: true,
                    obscureText: isVisibleConfirmPassword ,
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
                      labelText: 'Confirm Password',
                      contentPadding: EdgeInsets.only(left: 10.0),
                      suffixIcon: IconButton(
                        icon: isVisibleConfirmPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isVisibleConfirmPassword=!isVisibleConfirmPassword;
                          });
                        },
                      ),
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
                    ),
                    validator: forgetConfirmPasswordlengthvalidate,

                  ),
                ),
                 GestureDetector(
                  child: Container(
                    height: 42,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 30,left: 15,right: 15),
                    child: Text('Save',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                    padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onTap: (){
                    Utility.instance.hideKeyboard(context);
                    _saveNewPassword();
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));
                    // Navigator.pop(context)  ;
                  },
                ),
              ],
          ),
      ),
            ),
    ),
        )
    );
  }

  String forgetPasswordlengthvalidate(String value) {
    if (value.isEmpty) {
      return 'Please enter new password';
    } else if (value.length < 6) {
      return 'You have to enter at least 6 digit!';
    }
    return null;
  }

  String forgetConfirmPasswordlengthvalidate(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    } else if (value.length < 6) {
      return 'You have to enter at least 6 digit!';
    }
    return null;
  }

  void _saveNewPassword(){
    if(formkey.currentState.validate()){
      if (newPasswordController.text == confirmPasswordController.text) {
        setState(() {
          isloading = true;
        });
        if (SessionManager.getSelectedUser() == "User") {
          ForgetPasswordRequest forgetPasswordRequest = new ForgetPasswordRequest();
          forgetPasswordRequest.mobNo = widget.mobileNumber;
          forgetPasswordRequest.password = confirmPasswordController.text;
          forgetPasswordRequest.flag = 1;

          _forgetPasswordPresenter.postForgetPassword(forgetPasswordRequest);
        } else {
          ForgetPasswordRequest forgetPasswordRequest = new ForgetPasswordRequest();
          forgetPasswordRequest.mobNo = widget.mobileNumber;
          forgetPasswordRequest.password = confirmPasswordController.text;
          forgetPasswordRequest.flag = 0;

          _forgetPasswordPresenter.postForgetPassword(forgetPasswordRequest);
        }
      }else{
        toast().showToast("Your password and confirmation password do not match");
      }
    }
  }

  @override
  void postForgetPasswordError(String message) {
    setState(() {
      isloading=false;
    });
    // toast().showToast(message);
  }

  @override
  void postForgetPasswordSuccess(ForgetPasswordResponse forgetPasswordResponse) {
    setState(() {
      isloading=false;
    });
    toast().showToast(forgetPasswordResponse.message);
    Navigator.of(context).pop();

    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));

  }
}
