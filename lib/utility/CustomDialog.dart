import 'package:flutter/material.dart';
import 'package:mechon/model/response/VerifyNumberResponse.dart';
import 'package:mechon/screen/forgetPassword/ForgetPasswordScreen.dart';
import 'package:mechon/screen/registration/garage/GarageRegistrationScreen.dart';
import 'package:mechon/screen/registration/user/UserRegistrationScreen.dart';
import 'package:mechon/screen/verify/controller/VerifyNumberContract.dart';
import 'package:mechon/screen/verify/presenter/VerifyNumberPresenter.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class CustomDialog implements VerifyNumberContract{


   // CustomDialog({this.title,this.description,this.buttonText,this.context});

     //flag=1   verifyMobileNumber
     //flag=0

  static TextEditingController mobileNumberController=new TextEditingController();

     static showDialogBox(BuildContext context ,int flag,String otp){
       VerifyNumberPresenter _verifyNumberPresenter=new VerifyNumberPresenter(CustomDialog());

       return showDialog(
          context: context,
          builder: (BuildContext context){
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
                          child: Text('9657431432'),
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(bottom: 8,right: 8),

                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          child: TextField(
                            maxLines: 1,
                            maxLength: 4,
                            controller: mobileNumberController,
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
                            if(SessionManager.getSelectedUser()=="User"){
                              _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 0);
                            }else{
                              _verifyNumberPresenter.verifyNumber(mobileNumberController.text, "", 1, 1);
                            }
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
                            if(mobileNumberController.text.isEmpty){
                              toast().showToast("Please Enter OTP");
                            }else{
                              if(flag==1){
                                SessionManager.init();
                                if(SessionManager.getSelectedUser()=="User"){
                                  if(mobileNumberController.text=="${otp}"){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => UserRegistrationScreen()));
                                    Navigator.of(context).pop();
                                    mobileNumberController.text="";
                                  }else{
                                    toast().showToast("Please Enter Correct OTP");
                                  }
                                }else{
                                  if(mobileNumberController.text==otp){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => GarageRegistrationScreen()));
                                    Navigator.of(context).pop();
                                    mobileNumberController.text="";
                                  }else{
                                    toast().showToast("Please Enter Correct OTP");
                                  }
                                }
                              }else{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext cotext) => ForgetPasswordScreen(mobileNumber:"9657431432")));
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
          }
      );
    }

  @override
  void verifyNumberError(String message) {
    toast().showToast(message);

  }

  @override
  void verifyNumberSuccess(VerifyNumberResponse verifyNumberResponse) {
    if(verifyNumberResponse.otp==null){
      toast().showToast(verifyNumberResponse.message);
    }else{
      toast().showToast(verifyNumberResponse.otp);
    }
  }


    // void _verifyOtp(int flag){
    //    if(flag==1){
    //
    //    }
    // }


}
