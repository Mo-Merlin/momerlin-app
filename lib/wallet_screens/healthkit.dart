import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health/health.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthKit extends StatefulWidget {
  @override
  _HealthKit createState() => _HealthKit();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

class _HealthKit extends State<HealthKit> {
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  @override
  void initState() {
     fetchData();
    super.initState();
    permission();
  }

  Future<void> permission() async {
    if (Platform.isAndroid) {
      final permissionStatus = Permission.activityRecognition.request();
      if (await permissionStatus.isDenied ||
          await permissionStatus.isPermanentlyDenied) {
      
        // showToast(
        //     'activityRecognition permission required to fetch your steps count');
        return;
      }
    }
  }

  /// Fetch data from the health plugin and print it
  Future fetchData() async {
    // get everything from midnight until now
    DateTime startDate = DateTime(2021, 10, 25, 0, 0, 0);
    DateTime endDate = DateTime(2025, 11, 07, 23, 59, 59);

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [
      HealthDataType.WAIST_CIRCUMFERENCE,
     
     
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    int steps = 0;

    if (accessWasGranted) {
      print("PATTU $accessWasGranted");
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      _healthDataList.forEach((x) {
        print("Data point: $x");
        steps += x.value.round();
      });

      print("Steps: $steps");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(
            strokeWidth: 10,
          ),
        ),
        Text(
          'Fetching data...',
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }

  Widget _contentDataReady() {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: _healthDataList.length,
        itemBuilder: (_, index) {
          HealthDataPoint p = _healthDataList[index];
          print(
            "1234567 $p");
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text('${p.unitString}'),
           
          );
        });
  }

  Widget _contentNoData() {
    return Text('No Data to show');
  }

  Widget _contentNotFetched() {
    return Text('pavi');
  }

  Widget _authorizationNotGranted() {
    return Text('''Authorization not given.
        For Android please check your OAUTH2 client ID is correct in Google Developer Console.
         For iOS check your permissions in Apple Health.''');
  }

  Widget _content() {
    print("1234567890- $AppState");
    if (_state == AppState.DATA_READY){
    print("pavmu $_state");
      return _contentDataReady();}
    else if (_state == AppState.NO_DATA)
    {
      print("pav $_state");
      return _contentNoData();
    }else if (_state == AppState.FETCHING_DATA){
      print("pavi $_state");
      return _contentFetchingData();
    }else if (_state == AppState.AUTH_NOT_GRANTED){
      print("wertyui $_state");
      return _authorizationNotGranted();
    }
    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: blue,
            title: const Text('Google Fit'),
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  GestureDetector(
                    onTap: () {
                      fetchData();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Connect Health Kit",
                          style: GoogleFonts.poppins(
                              fontSize: 8,
                              color: blue1,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: _content(),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
