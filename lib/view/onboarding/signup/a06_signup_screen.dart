// import 'package:flutter/material.dart';
// import '../../model/controller/appbar.dart';
// import '../../model/controller/button.dart';
// import '../../model/controller/textfield.dart';
// import 'a07_signup_screen.dart';

// class A06SignupScreen extends StatelessWidget {
//   A06SignupScreen({super.key});
//   final bankNameTextEditingController = TextEditingController();
//   final accountNumberTextEditingController = TextEditingController();
//   final reAccountNumberTextEditingController = TextEditingController();
//   final holderNameTextEditingController = TextEditingController();
//   final ifscCodeTextEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     // final width = MediaQuery.of(context).size.width;
//     return SafeArea(
//         child: Scaffold(
//       appBar: const CustomBottomAppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: height * 0.045),
//             const Text(
//               'Upload minimum 3 images of your Business',
//               style: TextStyle(fontSize: 15),
//             ),
//             SizedBox(height: height * 0.045),
//             MyTextField(
//               hintText: 'Bank Name',
//               controller: bankNameTextEditingController,
//               keyboardType: TextInputType.name,
//               textInputAction: TextInputAction.next,
//             ),
//             MyTextField(
//               hintText: 'Account Number',
//               controller: accountNumberTextEditingController,
//               keyboardType: TextInputType.number,
//               textInputAction: TextInputAction.next,
//             ),
//             MyTextField(
//               hintText: 'Re Enter Account Number',
//               controller: reAccountNumberTextEditingController,
//               keyboardType: TextInputType.number,
//               textInputAction: TextInputAction.next,
//             ),
//             MyTextField(
//               hintText: 'Holder Name',
//               controller: holderNameTextEditingController,
//               keyboardType: TextInputType.name,
//               textInputAction: TextInputAction.next,
//             ),
//             MyTextField(
//               hintText: 'IFSC Code',
//               controller: ifscCodeTextEditingController,
//               keyboardType: TextInputType.streetAddress,
//               textInputAction: TextInputAction.done,
//             ),
//             SizedBox(height: height * 0.14),
//             Button().mainButton('Next', context, () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => A07SignupScreen()));
//             }),
//             SizedBox(height: height * 0.04),
//           ],
//         ),
//       ),
//     ));
//   }
// }
