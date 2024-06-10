import 'package:final_pro/pages/Register/SignUp.dart';
import 'package:flutter/material.dart';
import 'pages/Login/Login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/pages/Home/Map/Map.dart';
import 'package:final_pro/pages/ForgotPassword/ForgotPassword.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const Pages());
}

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
    return Scaffold(
      backgroundColor: const Color(0xff404040),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 115,
                height: 113,
                child: SvgPicture.asset('images/LogoSplash.svg'),
              )
            ],
          ),
          const Text('Car Car',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter-ExtraBold',
                  fontSize: 40))
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Login'),
//         ),
//         body: LoginForm(),
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   String _validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'Please enter your password';
//     }
//     return 'null';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction, // Validation occurs only on user interaction
//       child: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder(), prefixIcon: Icon(Icons.abc), suffixIcon: Icon(Icons.abc)),
//               validator: (value){
//                 if (value!.isEmpty) {
//                   return 'Please enter your username';
//                 }
//                 return 'null';
//               }
//             ),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
//               validator: (value){
//                 if (value!.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return 'null';
//               }
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   // If the form is valid, proceed with your login logic here
//                   print('Username: ${_usernameController.text}');
//                   print('Password: ${_passwordController.text}');
//                 }
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
