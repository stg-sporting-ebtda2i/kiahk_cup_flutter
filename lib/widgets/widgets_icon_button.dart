// import 'package:flutter/material.dart';
//
// Widget iconButton({
//   required VoidCallback onClick,
//   required IconData icon,
//   required String text,
// }) {
//   return ElevatedButton(
//     onPressed: onClick,
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.transparent,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(0),
//       ),
//     ),
//     child: Row(
//       // mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           size: 30,
//           color: Colors.white,
//         ),
//         const SizedBox(width: 10),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// import 'package:flutter/material.dart';
//
// Widget iconButton({
//   required VoidCallback onClick,
//   required IconData icon,
//   required String text,
// }) {
//   return SizedBox(
//     height: 180,
//     width: 325,
//     child: Opacity(
//       opacity: 0.75,
//       child: Container(
//         padding: const EdgeInsets.all(25),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(42),
//         ),
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.topLeft,
//               child: Icon(
//                 icon,
//                 size: 70,
//                 color: Colors.black,
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(8, 2, 0, 0),
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
//
// import 'package:flutter/material.dart';
//
// Widget iconButton({
//   required VoidCallback onClick,
//   required IconData icon,
//   required String text,
// }) {
//   return SizedBox(
//     width: 325,
//     height: 120,
//     child: Card(
//       elevation: 5, // Adds a shadow
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20), // Rounded corners
//       ),
//       child: InkWell(
//         onTap: onClick, // Handle button click
//         borderRadius: BorderRadius.circular(20), // Match the card's border radius
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.black12,
//             // gradient: LinearGradient(
//             //   colors: [Colors.blue.shade300, Colors.blue.shade600], // Gradient background
//             //   begin: Alignment.topLeft,
//             //   end: Alignment.bottomRight,
//             // ),
//           ),
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             children: [
//               Icon(
//                 icon,
//                 size: 40,
//                 color: Colors.black,
//               ),
//               const SizedBox(width: 20), // Spacing between icon and text
//               Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// //
import 'package:flutter/material.dart';

Widget iconButton({
  required VoidCallback onClick,
  required IconData icon,
  required String text,
}) {
  return GestureDetector(
    onTap: onClick,
    child: SizedBox(
      height: 100,
      width: 325,
      child: Opacity(
        opacity: 0.75,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(42),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}