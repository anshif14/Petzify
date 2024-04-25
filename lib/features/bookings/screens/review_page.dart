// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:luna_demo/features/home/screen/navbar.dart';
//
// import '../../../commons/color constansts.dart';
// import '../../../commons/widgets.dart';
// import '../../../main.dart';
//
// class Geolocation_page extends StatefulWidget {
//
//   const Geolocation_page({super.key});
//
//   @override
//   State<Geolocation_page> createState() => _Geolocation_pageState();
// }
// class _Geolocation_pageState extends State<Geolocation_page> {
//   Position ?_currentLocation;
//   late bool servicePermission=false;
//   late  LocationPermission permission;
//   String _currentAdress ="";
//   Future<Position> _getCurrentLocation() async {
//     servicePermission =await Geolocator.isLocationServiceEnabled();
//     if(!servicePermission){
//
//     }
//     permission=await Geolocator.checkPermission();
//
//     if(permission == LocationPermission.denied){
//       permission =await Geolocator.requestPermission();
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//   _getAddressFromCoordinates() async{
//     try{
//       List<Placemark> placemark =await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
//       Placemark place = placemark[0];
//       setState(() {
//         _currentAdress ="${place.locality},${place.country}";
//       });
//     }catch (e){
//
//     }
//   }
//
//   fetch()async{
//     _currentLocation =await _getCurrentLocation();
//     await _getAddressFromCoordinates();
//     setState(() {
//
//     });
//   }
//   @override
//   void initState() {
//     fetch();
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("geo location",style: TextStyle(fontWeight: FontWeight.w600)),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(child: Text("${_currentAdress}",style: TextStyle(
//                 fontSize: 60
//             ),)),
//             ElevatedButton(
//                 onPressed: () async {
//
//
//                 }, child: Text("button"))
//           ],
//         )
//     );
//   }
// }
