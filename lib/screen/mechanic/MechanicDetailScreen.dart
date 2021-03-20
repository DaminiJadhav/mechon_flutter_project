import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mechon/model/response/GetMechanicDetailResponse.dart';
import 'package:mechon/screen/home/garage/GarageHomeScreen.dart';
import 'package:mechon/screen/mechanic/AddMechanicDetailScreen.dart';
import 'package:mechon/screen/mechanic/controller/MechnicDetailContract.dart';
import 'package:mechon/screen/mechanic/presenter/MechanicDetailPresenter.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/ReadMoreText.dart';
import 'package:mechon/utility/SessionManager.dart';
import 'package:mechon/utility/Toast.dart';

class MechanicDetailScreen extends StatefulWidget {
  @override
  _MechanicDetailScreenState createState() => _MechanicDetailScreenState();
}

class _MechanicDetailScreenState extends State<MechanicDetailScreen> implements MechanicDetailController{


  MechanicDetailPresenter mechanicDetailPresenter;
  List<MechanicDetail> mechanicDetailSkillList=new List();
  bool isloading = false;
  MechanicDetail mechanicDetail=new MechanicDetail();
  bool isReadMore=false;
  int mechanicdetailsPosition;
  int mechanicDefaultList;

  _MechanicDetailScreenState(){
    mechanicDetailPresenter=new MechanicDetailPresenter(this);
  }

  @override
  void initState() {
    setState(() {
      isloading=true;
    });
    mechanicDetailPresenter.getMechanicDetail(int.parse(SessionManager.getGarageId()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Mechanic Detail'),

      ),

      body: _mechaniclist(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){
          _displayMechanicDetail(context,"AddMechanic",0,mechanicDetail);
          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => AddMechanicDetailScreen()));
        },
      ),
    );
  }


  Widget _mechaniclist(){
    return LoadingOverlay(
      isLoading: isloading,
      opacity: 0.5,
      color: Colors.white,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: MyColors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mechanicDetailSkillList.length,
        itemBuilder: (context,int position){
          return GestureDetector(
            onTap: (){
              _displayMechanicDetail(context,"UpdateMechanic",mechanicDetailSkillList[position].mechanicId,mechanicDetailSkillList[position]);
              // Navigator.push(context, MaterialPageRoute(builder: (BuildContext cotext) => AddMechanicDetailScreen()));
            },
            child: Card(
              margin: EdgeInsets.only(left: 26,right: 26,top: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 15,bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(mechanicDetailSkillList[position].firstName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 4),
                                        alignment: Alignment.centerLeft,
                                        child: Text(mechanicDetailSkillList[position].lastName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))
                                    ),
                                  ],
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(mechanicDetailSkillList[position].mobNo,style: TextStyle(fontSize: 15))
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: mechanicdetailsPosition==position ? mechanicDetailSkillList[position].mechanicSkillSet.length :1,
                                    itemBuilder: (context,int index){
                                      return GestureDetector(
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment:Alignment.centerLeft,
                                              child: Text(mechanicDetailSkillList[position].mechanicSkillSet[index].skillName,style: TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      );

                                    }
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                        isReadMore=!isReadMore;
                                        if(isReadMore){
                                          mechanicdetailsPosition=position;
                                        }else{
                                          mechanicdetailsPosition=-1;
                                        }
                                    });
                                  },
                                  child: mechanicdetailsPosition==position ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(mechanicDetailSkillList[position].mechanicSkillSet.length==1  ? "" :"..Show Less",style: TextStyle(color: Colors.lightBlueAccent),),
                                  ) : Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text( mechanicDetailSkillList[position].mechanicSkillSet.length==1  ? "" :"..Show More",style: TextStyle(color: Colors.lightBlueAccent),),
                                  ),
                                )
                                // Container(
                                //     alignment: Alignment.centerLeft,
                                //     child: Text('Skill')
                                // ),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            FlutterPhoneDirectCaller.callNumber(mechanicDetailSkillList[position].mobNo);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                              child: Icon(Icons.call)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }



  Future _displayMechanicDetail(BuildContext context,String mechanicdetail,int mechanicId,MechanicDetail mechanicDetail) async {
    var results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddMechanicDetailScreen(mechanicDetail: mechanicdetail,mechanicId:mechanicId,mechanicDetailPosition: mechanicDetail,);
    }));

    if (results != null && results.containsKey('MECHANICDETAILS')) {
      setState(() {
        try {
          String mechanicDetail = results["MECHANICDETAILS"];
          if(mechanicDetail!=""){
            mechanicDetailSkillList.clear();
            mechanicDetailPresenter.getMechanicDetail(int.parse(SessionManager.getGarageId()));
          }
          // print(mechanicDetail);

        }on Exception catch (exception){
          print(exception);
        };
      });
    }

  }

  @override
  void getMechanicDetailError(String message) {
    setState(() {
      isloading=false;
    });
    // toast().showToast(message);

  }

  @override
  void getMechanicDetailSuccess(GetMechanicDetailResponse getMechanicDetailResponse) {
    setState(() {
      isloading=false;
    });
    mechanicDetailSkillList=getMechanicDetailResponse.mechanicDetails;
    // toast().showToast(getMechanicDetailResponse.message);

  }
}
