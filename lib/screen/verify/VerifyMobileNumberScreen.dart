import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/response/VerifyNumberResponse.dart';
import 'package:mechon/screen/registration/garage/GarageRegistrationScreen.dart';
import 'package:mechon/screen/registration/user/UserRegistrationScreen.dart';
import 'package:mechon/screen/verify/controller/VerifyNumberContract.dart';
import 'package:mechon/screen/verify/presenter/VerifyNumberPresenter.dart';
import 'package:mechon/utility/CheckInternet.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/CustomDialog.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:mechon/utility/Utility.dart';

class VerifyMobileNumberScreen extends StatefulWidget {
  @override
  _VerifyMobileNumberScreenState createState() => _VerifyMobileNumberScreenState();
}

class _VerifyMobileNumberScreenState extends State<VerifyMobileNumberScreen> implements VerifyNumberContract{
  TextEditingController mobileNumberController=new TextEditingController();
  TextEditingController otpController=new TextEditingController();
  String _otp;

  static String mobileNumber = r'(^[789]\d{9}$)';
  RegExp regexMobile = new RegExp(mobileNumber);

  bool ismobile=true;
  VerifyNumberPresenter _verifyNumberPresenter;
  // checkInternet _internet;

  bool _isloading = false;
  bool _resendOtp = false;


  _VerifyMobileNumberScreenState(){
    _verifyNumberPresenter=new VerifyNumberPresenter(this);
  }

  @override
  void initState() {
    SessionManager.init();
    // _internet=new checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      // appBar: CurveAppBar.getAppbar("Registration", context),
      body: _verifyNumber(),

    );
  }

  Widget _verifyNumber(){
    return LoadingOverlay(
      isLoading:_isloading ,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mobileNumberController,
              enabled: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 1,
                    color: MyColors.red[200],
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: MyColors.red,
                    )),
                labelText: 'Mobile Number',
                contentPadding: EdgeInsets.only(left: 10.0),
                errorText: ismobile ? "Enter valid phone number" : null
//                        contentPadding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0)
              ),
              maxLength: 10,
              onChanged: (value){


                if(mobileNumberController.text.isEmpty){
                  setState(() {
                    ismobile=false;
                  });
                }else if(regexMobile.hasMatch(mobileNumberController.text)){
                  setState(() {
                    ismobile=false;
                  });
                }else{
                  setState(() {
                    ismobile=true;
                  });
                }
              },
            ),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 30),
                child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onTap: (){
                if(ismobile){

                }else{
                  // _internet.check().then((value) {
                  //   if (value != null && value) {
                      if(SessionManager.getSelectedUser()=="User"){
                        _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 0);
                        setState(() {
                          _isloading = true;
                        });

                        // if(_otp!=""){
                        //   _showDialogue(context,_otp);
                        // }
                        Utility.instance.hideKeyboard(context);
                      }else{
                        _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 1);
                        setState(() {
                          _isloading = true;
                        });
                        // if(_otp!=""){
                        //   _showDialogue(context,_otp);
                        // }
                        Utility.instance.hideKeyboard(context);
                      }
                    // } else {
                    //   toast().showToast('Please check your internet connection.');
                    // }
                  // });

                }
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => LoginScreen()));
                // Navigator.pop(context)  ;
              },
            ),

          ],
        ),
      ),
    );
  }




  @override
  void verifyNumberError(String message) {
    setState(() {
      _isloading = false;
    });
    toast().showToast(message);
  }

  @override
  void verifyNumberSuccess(VerifyNumberResponse verifyNumberResponse) {
    setState(() {
      _isloading = false;
    });
      if(verifyNumberResponse.otp==null){
        toast().showToast(verifyNumberResponse.message);
      }else{
        toast().showToast(verifyNumberResponse.otp);
        if(_resendOtp){
          setState(() {
            _resendOtp=false;
          });
        }else{
          _showDialogue(context,_otp);
        }
        _otp=verifyNumberResponse.otp;

        // CustomDialog .showDialogBox(context,1,verifyNumberResponse.otp);
      }

  }

  _showDialogue(BuildContext context,String otp) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Wrap(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                  ),
                  child: Column(
                    children: [
                      Text("OTP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Container(
                        margin: EdgeInsets.only(bottom: 4,top: 4),
                        child: Text('We have sent an OTP on your'),
                      ),
                      Container(
                        child: Text('Mobile Number : '),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(mobileNumberController.text),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        // padding: EdgeInsets.only(bottom: 8,right: 8),

                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: TextField(
                          maxLines: 1,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "OTP",
                            contentPadding: EdgeInsets.only(left: 10),
                            border: InputBorder.none,

                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: Text('Resend OTP ?'),
                        ),
                        onTap: (){
                          // _internet.check().then((value) {
                          //   if (value != null && value) {
                              otpController.text="";
                              if(SessionManager.getSelectedUser()=="User"){
                                _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 0);
                                setState(() {
                                  _isloading = true;
                                  _resendOtp=true;
                                });
                                Utility.instance.hideKeyboard(context);
                              }else{
                                _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 1);
                                setState(() {
                                  _isloading = true;
                                  _resendOtp=true;
                                });
                                Utility.instance.hideKeyboard(context);
                              }
                          //   } else {
                          //     toast().showToast('Please check your internet connection.');
                          //   }
                          // });
                          // if(SessionManager.getSelectedUser()=="User"){
                          //   _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 0);
                          // }else{
                          //   _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 1);
                          // }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          margin: EdgeInsets.only(top: 20),
                          child: Text('Verify',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.red
                          ),
                        ),
                        onTap: (){
                          if(otpController.text.isEmpty){
                            toast().showToast("Please Enter OTP");
                          }else{
                            if(otpController.text==_otp){
                              if(SessionManager.getSelectedUser()=="User"){
                                // Navigator.popAndPushNamed(context, '/userRegistration');
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => UserRegistrationScreen(mobileNumber: mobileNumberController.text,)));
                                // Navigator.of(context).pop();
                                otpController.text="";
                              }else{
                                // Navigator.popAndPushNamed(context, '/garageRegistration');
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => GarageRegistrationScreen(mobilenumber:mobileNumberController.text)));
                                // Navigator.of(context).pop();
                                otpController.text="";
                              }
                            }else{
                              toast().showToast("Please Enter Correct OTP");
                            }
                          }

                        },
                      )
                    ],
                  ),
                ),
              ],

            ),
          );
        });
  }

}
