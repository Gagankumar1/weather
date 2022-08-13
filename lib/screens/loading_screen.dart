import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

//import 'package:flutter/foundation.dart';
//import 'dart:convert';
import 'package:flutter/material.dart';




class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // late double latitude;
  // late double longitude;


  @override
  void initState() {
    super.initState();
    getLocationData();
  }
  void getLocationData() async{
    //WeatherModel weatherModel=WeatherModel();
    var weatherData=await WeatherModel().getLocationWeather();
    if(!mounted)return;

        Navigator.push(context, MaterialPageRoute(builder:(context){
          return  LocationScreen(locationWeather:weatherData);

     },
        ),
        );
  }

  //void getData()async{
  // http.Response response=await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=longitude&appid=$apiKey'));
  //    if(response.statusCode==200){
  //      String data=response.body;
  //
  // var decodedData=jsonDecode(data);
  //double temperature=decodedData['main']['temp'];
  //int condition=decodedData['weather'][0]['id'];
  //String cityName=decodedData['name'];

  // if (kDebugMode) {
  //   print(temperature);
  // }
  // if (kDebugMode) {
  //   print(condition);
  // }
  // if (kDebugMode) {
  //   print(cityName);
  // }
  // }
  //

  // else{
  //
  //   print(response.status.code);
  // }
  // }
  @override
  Widget build(BuildContext context) {

    return  const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}


