// import 'package:connectivity/connectivity.dart';
// import 'package:http/http.dart' as http;
//
// class NetworkService {
//   Future<bool> isOnline() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       return false; // No network connection
//     }
//
//     // Check if the device has internet access
//     try {
//       final response = await http.get(Uri.parse('https://www.google.com'));
//       return response.statusCode == 200;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   // Future<bool> _isOnline() async {
//   //   var connectivityResult = await Connectivity().checkConnectivity();
//   //   return connectivityResult != ConnectivityResult.none;
//   // }
// }