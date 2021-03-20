import 'package:flutter/material.dart';
import 'package:mechon/model/response/VehicleIssueResponse.dart';
import 'package:mechon/model/response/VehicleTypeListResponse.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/screen/registration/garage/presenter/VehicleTypeListPresenter.dart';
import 'package:mechon/screen/vehicleIssue/VehicleIssueScreen.dart';
import 'package:mechon/screen/vehicleIssue/controller/VehicleIssueController.dart';
import 'package:mechon/screen/vehicleIssue/presenter/VehicleIssuePresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/Toast.dart';

class SelectYourProblemScreen extends StatefulWidget {
  @override
  _SelectYourProblemScreenState createState() => _SelectYourProblemScreenState();
}

class _SelectYourProblemScreenState extends State<SelectYourProblemScreen> implements VehicleIssueContract {
  bool isSelectGarageType=false;
  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  VehicleIssuePresenter vehicleIssuePresenter;
  List<bool> _isChecked;
  bool isOtherSelect=false;
  List<VehicleIssueType> vehicleType = new List();

  TextEditingController writeIssueController = new TextEditingController();


  List<VehicleIssueType> isSelectedYourProblem=new List();

  var results;


  _SelectYourProblemScreenState() {
    vehicleIssuePresenter = new VehicleIssuePresenter(this);
  }

  @override
  void initState() {
    // _isChecked=List<bool>.filled(_texts.length, false);
    vehicleIssuePresenter.getVehicleIssue();



  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Vehicle Issues'),
      ),
      // appBar: CurveAppBar.getAppbar("Mechon", context),
      body: _getGarageTypeList(),
    );
  }


  Widget _getGarageTypeList(){
    return vehicleType.length != 0  ? Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15,bottom: 25),
          child: Text('Select Your Problem',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: vehicleType.length,
            itemBuilder: (context,int position){
              return Column(
                children: [
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicleType[position].peoblem,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        ),
                        Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            // checkColor: Colors.blue,
                            value: _isChecked[position],
                            onChanged: (val){
                              setState(() {
                                _isChecked[position]=val;

                                if(_isChecked[position]==true){
                                  // isSelectedYourProblem.add(vehicleType[position].vehicleType);
                                  isSelectedYourProblem.add(vehicleType[position]);
                                  setState(() {
                                    if(vehicleType[position].peoblem=="Others"){
                                      isOtherSelect=true;
                                    }
                                  });
                                }else{
                                  isOtherSelect=false;

                                  isSelectedYourProblem.remove(
                                      vehicleType[position]);
                                  // isSelectedYourProblem.remove(vehicleType[position].vehicleType);
                                }


                              });
                            }),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 15,right: 15),
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
          flex: 4,
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
            margin: EdgeInsets.only(bottom: 40,left: 15,right: 15),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor
            ),
            child: Text('Select',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
          onTap: (){
            if(isOtherSelect){
              if(writeIssueController.text.isEmpty){
                toast().showToast("Please Write Your Vehicle Issue");
              }else{
                Navigator.of(context).pop({"VehicleIssue": isSelectedYourProblem,
                                           "VehicleIssueText":writeIssueController.text});
              }
            }else{
              Navigator.of(context).pop({"VehicleIssue": isSelectedYourProblem});
            }


            // print(isSelectedGarageType);
          },
        )
      ],
    ) :
    Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.red,
      ),
    );
  }




  @override
  void getVehicleIssueListError(String message) {
    toast().showToast(message);

  }

  @override
  void getVehicleIssueListSuccess(VehicleIssueResponse vehicleIssueResponse) {
    setState(() {
      vehicleType = vehicleIssueResponse.vehicleType;
      _isChecked = List<bool>.filled(vehicleType.length, false);
    });

  }





}
