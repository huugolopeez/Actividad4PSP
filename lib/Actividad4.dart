import 'package:actividad4/singletone/DataHolder.dart';
import 'package:actividad4/splash/SplashView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'main/GestionView.dart';
import 'main/MHomeView.dart';
import 'main/PostCreateView.dart';
import 'main/PostView.dart';
import 'main/WHomeView.dart';
import 'onBoarding/MLoginView.dart';
import 'onBoarding/MRegisterView.dart';
import 'onBoarding/PerfilView.dart';
import 'onBoarding/PhoneLoginView.dart';
import 'onBoarding/WLoginView.dart';
import 'onBoarding/WRegisterView.dart';

class Actividad4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    MaterialApp materialApp;

    if(kIsWeb) {
      materialApp = MaterialApp(
          title: '3PMDM',
          theme: ThemeData(fontFamily: DataHolder().plAdmin.getFont()),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashview',
          routes: {
            '/loginview': (context) => WLoginView(),
            '/registerview': (context) => WRegisterView(),
            '/homeview': (context) => WHomeView(),
            '/splashview': (context) => SplashView(),
            '/perfilview': (context) => PerfilView(),
            '/postview': (context) => PostView(),
            '/postcreateview': (context) => PostCreateView(),
            '/gestionview': (context) => GestionView()
          }
      );
    } else {
      materialApp = MaterialApp(
          title: '3PMDM',
          theme: ThemeData(fontFamily: DataHolder().plAdmin.getFont()),
          debugShowCheckedModeBanner: false,
          initialRoute: '/splashview',
          routes: {
            '/loginview': (context) => MLoginView(),
            '/registerview': (context) => MRegisterView(),
            '/homeview': (context) => MHomeView(),
            '/splashview': (context) => SplashView(),
            '/perfilview': (context) => PerfilView(),
            '/postview': (context) => PostView(),
            '/postcreateview': (context) => PostCreateView(),
            '/phoneloginview': (context) => PhoneLoginView()
          }
      );
    }

    return materialApp;
  }
}