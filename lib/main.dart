import 'package:flutter/material.dart';
import 'pages/Login/Login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/usable/Components/Helper.dart';
import 'package:final_pro/pages/Home/MainMenu.dart';
import 'package:final_pro/pages/Home/Map/MapModel.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    ChangeNotifierProvider(
        create: (context)=> MapModel(),
        child: Pages(),
    )
  );
}

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
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
    Future.delayed(const Duration(seconds: 2), () async {
      bool isLoggedIn = await Helper.getUserLoggedInSharedPreference();
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(
        //   builder: (context) => isLoggedIn ? const MainMenu() : const Login(),
        // ),
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: const Color(0xff404040),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 115, height: 113, child: SvgPicture.asset('images/LogoSplash.svg'))
            ],
          ),
          const Text('Car Care', style: TextStyle(color: Colors.white, fontFamily: 'Inter-ExtraBold', fontSize: 40))
        ],
      ),
    );
  }
}



