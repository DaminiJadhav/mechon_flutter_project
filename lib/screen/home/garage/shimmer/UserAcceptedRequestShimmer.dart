
// UserAcceptedRequestShimmer


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class UserAcceptedRequestShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
//        period: Duration(seconds: 3),
        child: ShimmerListData(),
        baseColor: Colors.grey[300],
        highlightColor: Colors.white);
//    return ShimmerListData();
  }

}
class ShimmerListData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.all(20),
          //   alignment: Alignment.centerLeft,
          //   width: 50,
          //   height: 10.0,
          //   color: Colors.white,
          // ),
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context,int index){
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: ShimmerLayout()
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),

      child: Center(
        child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 6.0),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            width: double.infinity,
                            height: 15.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                height: 10.0,
                                color: Colors.white,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 30,
                                height: 10.0,
                                color: Colors.white,
                              ),
                            ],
                          ),

                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Row(
                              children: <Widget>[
                                Container(

                                  width: 30,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 30,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:  Container(
                        margin: const EdgeInsets.only(top: 10,right: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerRight,

                      ),
                    ),
                  ],
                ),
              )
            ]

        ),

      ),
    );
  }
}


