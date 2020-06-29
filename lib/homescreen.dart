import 'package:flutter/material.dart';
import 'package:covid19tracer/app/services/api.dart';
import 'package:covid19tracer/app/services/api_service.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeonHome createState() => HomeonHome();
}

ProgressDialog pr;

String _accessToken = '';
int _cases;
int _deaths;
int _recovered;
int _suspected;
int _confirmed;

class HomeonHome extends State<HomeScreen> {
  void _updateAccessToken() async {
    final apiService = APIService(API.sandbox());
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.cases,
    );
    final deaths = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.deaths,
    );
    final recovered = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.recovered,
    );
    final suspected = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.casesSuspected,
    );
    final confirmed = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.casesConfirmed,
    );
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _deaths = deaths;
      _recovered = recovered;
      _suspected = suspected;
      _confirmed = confirmed;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          //Container for top data
          Container(
            decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/background_splash.png"),
        fit: BoxFit.cover,
      )),
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Covid19 Tracker ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Text(
                  "nubentos.com",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.blueGrey),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          // // Container(
                          // //   decoration: BoxDecoration(
                          // //       color: Color.fromRGBO(243, 245, 248, 1),
                          // //       borderRadius:
                          // //           BorderRadius.all(Radius.circular(18))),
                          // //   child: Icon(
                          // //     Icons.adb,
                          // //     color: Colors.black54,
                          // //     size: 30,
                          // //   ),
                          // //   padding: EdgeInsets.all(12),
                          // // ),
                          // // SizedBox(
                          // //   height: 4,
                          // // ),
                          // // Text(
                          // //   "Cases",
                          // //   style: TextStyle(
                          // //       fontWeight: FontWeight.w700,
                          // //       fontSize: 14,
                          // //       color: Colors.grey),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Color.fromRGBO(243, 245, 248, 1),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(18))),
                          //   child: Icon(
                          //     Icons.public,
                          //     color: Colors.black54,
                          //     size: 30,
                          //   ),
                          //   padding: EdgeInsets.all(12),
                          // ),
                          // SizedBox(
                          //   height: 4,
                          // ),
                          // Text(
                          //   "Country",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 14,
                          //       color: Colors.grey),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Icon(
                              Icons.fingerprint,
                              color: Colors.black54,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Data",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Color.fromRGBO(243, 245, 248, 1),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(18))),
                          //   child: Icon(
                          //     Icons.trending_down,
                          //     color: Colors.black54,
                          //     size: 30,
                          //   ),
                          //   padding: EdgeInsets.all(12),
                          // ),
                          // SizedBox(
                          //   height: 4,
                          // ),
                          // Text(
                          //   "Chart",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: 14,
                          //       color: Colors.grey),
                          // ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Global Cases",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.grey[800]),
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      //Container for buttons
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: _updateAccessToken,

                                    // await pr.show(),
                                  ),
                                  Text(
                                    "Refresh",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.grey[900]),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 10.0,
                                        spreadRadius: 4.5)
                                  ]),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 1,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            // InkWell(
                            //   onTap: _updateAccessToken,
                            //   child: CircleAvatar(
                            //     // backgroundImage: ExactAssetImage('assets/cat.jpg'),
                            //     radius: 10,
                            //   ),
                            // ),

                            // Container(
                            //   child: Row(
                            //     children: <Widget>[
                            //       CircleAvatar(
                            //         radius: 8,
                            //         backgroundColor: Colors.orange,
                            //       ),
                            //       SizedBox(
                            //         width: 8,
                            //       ),

                            //       Text(
                            //         "Old",
                            //         style: TextStyle(
                            //             fontWeight: FontWeight.w700,
                            //             fontSize: 14,
                            //             color: Colors.grey[900]),
                            //       ),
                            //     ],
                            //   ),
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(20)),
                            //       boxShadow: [
                            //         BoxShadow(
                            //             color: Colors.grey[200],
                            //             blurRadius: 10.0,
                            //             spreadRadius: 4.5)
                            //       ]),
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 20, vertical: 10),
                            // )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      //Container Listview for expenses and incomes
                      Container(
                        child: Text(
                          "TODAY",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500]),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),

                      SizedBox(
                        height: 16,
                      ),

//---------------------------------

                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Icon(
                                    Icons.adb,
                                    color: Colors.black54,
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Cases",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      // Text("Payment from Saad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (_cases != null)
                                      Text(
                                        '$_cases',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightGreen),
                                      ),
                                    // Text("24 Feb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: true),
                      ),
//----------------------------------
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Icon(
                                    Icons.verified_user,
                                    color: Colors.black54,
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Confirmed",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      // Text("Payment from Saad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (_confirmed != null)
                                      Text(
                                        '$_confirmed',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightGreen),
                                      ),
                                    // Text("24 Feb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: true),
                      ),

                      //-----------------------------------
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.black54,
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Death",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      // Text("Payment from Saad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (_deaths != null)
                                      Text(
                                        '$_deaths',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightGreen),
                                      ),
                                    // Text("24 Feb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: true),
                      ),
//-----------------------------------------------------
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Icon(
                                    Icons.directions_walk,
                                    color: Colors.black54,
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Suspected",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      // Text("Payment from Saad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (_suspected != null)
                                      Text(
                                        '$_suspected',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightGreen),
                                      ),
                                    // Text("24 Feb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: true),
                      ),
//----------------------------------------------
                      ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Icon(
                                    Icons.healing,
                                    color: Colors.black54,
                                  ),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Recovered",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      // Text("Payment from Saad", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    if (_recovered != null)
                                      Text(
                                        '$_recovered',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.lightGreen),
                                      ),
                                    // Text("24 Feb", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 1,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: true),
                      ),
                      //now expense
                      SizedBox(
                        height: 16,
                      ),

                      Container(
                        child: Text(
                          "YESTERDAYY",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500]),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      // Text(
                      //   'You have pushed the button this many times:',
                      // ),
                      Container(
                        child: Text(
                          'accesstoken : $_accessToken',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500]),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      //now expense
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }

  // void setState(Null Function() param0) {}

}
