import 'package:flutter/material.dart';
import 'package:mechon/model/model/VehicleTypeAndId.dart';
import 'package:mechon/model/response/VehicleTypeListResponse.dart';
import 'package:mechon/screen/registration/garage/controller/VehicleTypeListContract.dart';
import 'package:mechon/screen/registration/garage/presenter/VehicleTypeListPresenter.dart';
import 'package:mechon/utility/CurveAppBar.dart';
import 'package:mechon/utility/MyColor.dart';
import 'package:mechon/utility/Toast.dart';

class SelectYourGarageType extends StatefulWidget {
  @override
  _SelectYourGarageTypeState createState() => _SelectYourGarageTypeState();
}

class _SelectYourGarageTypeState extends State<SelectYourGarageType>
    implements VehicleTypeListContract {
  VehicleTypeListPresenter vehicleTypeListPresenter;
  List<VehicleTypeAndId> _vehicleTypeAndId = new List();

  bool isSelectGarageType = false;
  List<String> _texts = [
    "InduceSmile.com",
    "Flutter.io",
    "google.com",
    "youtube.com",
    "yahoo.com",
    "gmail.com"
  ];

  List<bool> _isChecked;
  List<String> isSelectedGarageId = new List();
  List<String> isSelectedGarageType = new List();

  List<VehicleType> vehicleType = new List();
  List<VehicleType> vehicleTypeSelected = new List();

  @override
  void initState() {
    // _isChecked=List<bool>.filled(_texts.length, false);

    vehicleTypeListPresenter.getVehicleTypeList();
  }

  _SelectYourGarageTypeState() {
    vehicleTypeListPresenter = new VehicleTypeListPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mechon"),
      ),
      // appBar: CurveAppBar.getAppbar("Mechon", context),
      body: _getGarageTypeList(),
    );
  }

  Widget _getGarageTypeList() {
    return vehicleType.length != 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 25),
                child: Text(
                  'Select Garage Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: vehicleType.length,
                  itemBuilder: (context, int position) {
                    return Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vehicleType[position].vehicleType,
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
                                        vehicleTypeSelected
                                            .add(vehicleType[position]);
                                        isSelectedGarageId.add(
                                            vehicleType[position]
                                                .vehicleTypeId
                                                .toString());
                                        isSelectedGarageType.add(
                                            vehicleType[position]
                                                .vehicleType
                                                .toString());

                                        // _vehicleTypeAndId.add(VehicleTypeAndId(vehicleId: vehicleType[position].vehicleTypeId.toString(),vehicleType: vehicleType[position].vehicleType));

                                      } else {
                                        vehicleTypeSelected
                                            .remove(vehicleType[position]);
                                        isSelectedGarageId.remove(
                                            vehicleType[position]
                                                .vehicleTypeId
                                                .toString());
                                        isSelectedGarageType.remove(
                                            vehicleType[position]
                                                .vehicleType
                                                .toString());
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
                  Navigator.of(context).pop({
                    "GARAGETYPESID": isSelectedGarageId,
                    "GARAGETYPES": isSelectedGarageType,
                    "VEHICLETYPESELECTED": vehicleTypeSelected
                  });

                  // print(isSelectedGarageType);
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
  void getVehicleTypeListError(String message) {
    toast().showToast(message);
  }

  @override
  void getVehicleTypeListSuccess(
      VehicleTypeListResponse vehicleTypeListResponse) {
    // toast().showToast(vehicleTypeListResponse.message);
    setState(() {
      vehicleType = vehicleTypeListResponse.vehicleType;
      _isChecked = List<bool>.filled(vehicleType.length, false);
    });
  }
}
