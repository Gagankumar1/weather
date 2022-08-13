import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
//import 'package:flutter/foundation.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key,this.locationWeather}) : super(key: key);
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? temperature;
  WeatherModel weather=WeatherModel();
  String? weatherIcon;
  String? weatherMassage;
  String? cityName;
  @override
  void initState(){
    super.initState();
    updateUi(widget.locationWeather);
  }
  void updateUi(dynamic weatherData){
    setState(() {
      if(weatherData==null){
        temperature=0;
        weatherIcon='error';
        weatherMassage='unable to get weatherData';
        cityName='';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMassage = weather.getMessage(temperature!);
      cityName = weatherData['name'];

      // if (kDebugMode) {
      //   print(temperature);
      // }
    });


  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/background_g.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData= await weather.getLocationWeather();
                      updateUi(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const CityScreen();
                      },),);
                      if(typedName!=null){
                        var weatherData=await weather.getCityWeather(typedName);
                        updateUi(weatherData);

                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                      Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMassage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}


