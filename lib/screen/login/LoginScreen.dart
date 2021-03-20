import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/request/GarageLoginRequest.dart';
import 'package:mechon/model/request/UserLoginRequest.dart';
import 'package:mechon/model/response/ForgetPasswordResponse.dart';
import 'package:mechon/model/response/GarageLoginResponse.dart';
import 'package:mechon/model/response/UserLoginResponse.dart';
import 'package:mechon/model/response/VehicleIssueResponse.dart';
import 'package:mechon/model/response/VerifyNumberResponse.dart';
import 'package:mechon/screen/forgetPassword/ForgetPasswordScreen.dart';
import 'package:mechon/screen/forgetPassword/controller/ForgetPasswordController.dart';
import 'package:mechon/screen/home/garage/GarageHomeScreen.dart';
import 'package:mechon/screen/home/user/UserHomeScreen.dart';
import 'package:mechon/screen/login/contoller/LoginController.dart';
import 'package:mechon/screen/login/presenter/LoginPresenter.dart';
import 'package:mechon/screen/vehicleIssue/VehicleIssueScreen.dart';
import 'package:mechon/screen/verify/VerifyMobileNumberScreen.dart';
import 'package:mechon/screen/verify/controller/VerifyNumberContract.dart';
import 'package:mechon/screen/verify/presenter/VerifyNumberPresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/CustomDialog.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';
import 'package:mechon/utility/Utility.dart';



GoogleSignIn _googleSignIn=GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]
);


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginController,VerifyNumberContract{


  TextEditingController usernameController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController otpController=new TextEditingController();

  static String mobileNumber = r'(^[789]\d{9}$)';

  bool isloading = false;
  bool isClickForgetPassword = false;
  bool isResentOtp=false;
  String otp;


  RegExp regexMobile = new RegExp(mobileNumber);
  bool isVisiblePassword=true;


  LoginPresenter loginPresenter;
  VerifyNumberPresenter verifyNumberPresenter;

  final formkey = GlobalKey<FormState>();


  _LoginScreenState(){
    loginPresenter=new LoginPresenter(this);
    verifyNumberPresenter=new VerifyNumberPresenter(this);

  }


  @override
  void initState() {
    SessionManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechon'),
      ),
      // appBar: CurveAppBar.getAppbar("Mechon", context),
      body: LoadingOverlay(
        isLoading: isloading,
        opacity: 0.5,
        color: Colors.white,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: MyColors.red,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      enabled: true,
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
                        if(usernameController.text.isEmpty){
                          return "Please Enter Mobile Number ";
                        }else if(!regexMobile.hasMatch(usernameController.text)){
                          return "Please Enter Valid Mobile Number ";
                        }
                      },

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: isVisiblePassword,
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

                          if(isClickForgetPassword){
                            setState(() {
                              isClickForgetPassword=false;
                            });
                          }else{
                            if(passwordController.text.isEmpty){
                              return "Please Enter Password ";
                            }
                          }

                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        _forgetPassword();
                        // CustomDialog.showDialogBox(context,2,"0989");
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 6),
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password ?',style: TextStyle(fontWeight: FontWeight.bold),)
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 50,left: 12,right: 12),
                        child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                        padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      onTap: (){
                        Utility.instance.hideKeyboard(context);

                        _loginUserandGarage();

                      },
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text('or',style: TextStyle(fontSize: 18),)
                    ),
                    _socialMediaLogin(),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account yet?',style: TextStyle(fontSize: 14)),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => VerifyMobileNumberScreen()));

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Sign Up',style: TextStyle(color: Colors.blue,fontSize: 15),),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),



          ),
        ),
      ),
    );
  }


  Widget _socialMediaLogin(){
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/facebook.png",
                  width: 20.0,
                  height: 20.0,
                ),
//                   child:_isLoggedIn ?  Image.network(userProfile["picture"]["data"]["url"],width: 20.0,height: 20.0,) : Image.asset("images/facebook.png",width: 20.0,height: 20.0,),
              ),
            ),
            onTap: () {
//                  if(_isLoggedIn==true){
//                    facebooklogin.logOut();
//                    print('logout');
//                  }else {
//               onLoginSatusChanged(false);
//               _loginwWithFacebook();
//               print('login');

//                  }
            },
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/google.png",
                    width: 20.0,
                    height: 20.0,
                  ),
                ),
              ),
            ),
            onTap: () {
              _googleLoginMethodHandle();
            },
          ),
        ],
      ),
    );
  }


  Future<void> _googleLoginMethodHandle() async{
    try{
      // await _googleSignIn.signOut();
      // print("logout");

      await _googleSignIn.signIn();
      _googleSignIn.clientId;
      print("${_googleSignIn.currentUser.email}");
      print("${_googleSignIn.currentUser.id}");
      print("${_googleSignIn.currentUser.displayName}");
      print("${_googleSignIn.currentUser.photoUrl}");
    }catch(error){
      print(error);
    }
  }

  void _loginUserandGarage(){

    setState(() {
      isClickForgetPassword=false;
    });

    if(formkey.currentState.validate()){
      setState(() {
        isloading=true;
      });
      if(SessionManager.getSelectedUser()=="User"){
        UserLoginRequest userLoginRequest=new UserLoginRequest();
        userLoginRequest.mobNo=usernameController.text;
        userLoginRequest.password=passwordController.text;
        userLoginRequest.fCMTocken=SessionManager.getFirebaseToken();
        // userLoginRequest.fCMTocken="cE0MJcttTkaY1QcXx-6igq:APA91bFkodtGRsV15KU_aohSt2u_iHrx6MEOHItNdL3E6r0yEdj7jEZnIxMZLODH4UcQHjyITwuiZzYOQKuVnMWdMzsPeEDTFPayHcJ8ITY5uHdBjbX42X8GFJXVLTkmlW__UHBuHI1C";

        loginPresenter.postUserLogin(userLoginRequest);


      }else{
        GarageLoginRequest garageLoginRequest=new GarageLoginRequest();
        garageLoginRequest.mobNo=usernameController.text;
        garageLoginRequest.password=passwordController.text;
        garageLoginRequest.fCMTocken=SessionManager.getFirebaseToken();

        // garageLoginRequest.fCMTocken="cE0MJcttTkaY1QcXx-6igq:APA91bFkodtGRsV15KU_aohSt2u_iHrx6MEOHItNdL3E6r0yEdj7jEZnIxMZLODH4UcQHjyITwuiZzYOQKuVnMWdMzsPeEDTFPayHcJ8ITY5uHdBjbX42X8GFJXVLTkmlW__UHBuHI1C";



        loginPresenter.postGarageLogin(garageLoginRequest);

      }
    }else{
      // toast().showToast("Please enter login field");
    }


  }


  void _forgetPassword(){

    setState(() {
      isClickForgetPassword=true;
    });

    if(formkey.currentState.validate()){
      setState(() {
        isloading=true;
      });
      print("valid");
      if(SessionManager.getSelectedUser()=="User"){
        verifyNumberPresenter.verifyNumber(usernameController.text, "", 0, 0);
      }else{
        verifyNumberPresenter.verifyNumber(usernameController.text, "", 0, 1);
      }
    }else{
      print("not valid");
    }



  }


  _showDialogue(BuildContext context) {
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
                        child: Text(usernameController.text),
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

                          setState(() {
                            otpController.text="";
                          });
                          if(SessionManager.getSelectedUser()=="User"){
                            setState(() {
                              isResentOtp=true;
                            });
                            verifyNumberPresenter.verifyNumber(usernameController.text, "", 0, 0);
                          }else{
                            setState(() {
                              isResentOtp=true;
                            });
                            verifyNumberPresenter.verifyNumber(usernameController.text, "", 0, 1);
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
                          if(otpController.text.isEmpty){
                            toast().showToast("Please Enter OTP");
                          }else{
                            if(otpController.text==otp){
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => ForgetPasswordScreen(mobileNumber:usernameController.text)));
                              otpController.text="";
                            }else{
                              // otpController.text="";
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


  @override
  void postGarageLoginError(String message) {
    setState(() {
      isloading=false;
    });
    toast().showToast(message);
  }

  @override
  void postGarageLoginSuccess(GarageLoginResponse garageLoginResponse) {
    setState(() {
      isloading=false;
    });


    if(garageLoginResponse.status == 1) {
      SessionManager.setGarageId(garageLoginResponse.garage.garageRegistrationId.toString());

      toast().showToast(garageLoginResponse.message);
      Navigator.of(context).pop();

      Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => GarageHomeScreen()));

    }else{
      toast().showToast("Invalid username or password.");

    }

  }

  @override
  void postUserLoginError(String message) {
    setState(() {
      isloading=false;
    });
    toast().showToast(message);

  }

  @override
  void postUserLoginSuccess(UserLoginResponse userLoginResponse) {
    setState(() {
      isloading=false;
    });

    if(userLoginResponse.status == 1) {
      SessionManager.setUserId(userLoginResponse.response.id);
      SessionManager.setUserName(userLoginResponse.response.userName);
      toast().showToast(userLoginResponse.message);


      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext cotext) => VehicleIssueScreen()));
    }else{
      toast().showToast("Invalid username or password.");
    }

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => UserHomeScreen(),
    //       settings: RouteSettings(name: "/HomeScreen"),
    //     ),
    //     ModalRoute.withName("/Home"));

  }


  @override
  void verifyNumberError(String message) {
    setState(() {
      isloading=false;
    });
    toast().showToast(message);
  }

  @override
  void verifyNumberSuccess(VerifyNumberResponse verifyNumberResponse) {
    setState(() {
      isloading=false;
    });
    if(verifyNumberResponse.otp==null){
      toast().showToast("Mobile Number Does Not Exist");
    }else {
      toast().showToast(verifyNumberResponse.otp);
      setState(() {
        otp=verifyNumberResponse.otp;
      });
      if(isResentOtp){
        setState(() {
          isResentOtp=false;
        });
      }else{
        _showDialogue(context);
      }

    }
  }
}
