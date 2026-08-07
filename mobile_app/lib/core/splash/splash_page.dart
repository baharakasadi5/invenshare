import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/inventor_dashboard_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';



class SplashPage extends ConsumerStatefulWidget {


  const SplashPage({
    super.key,
  });



  @override
  ConsumerState<SplashPage> createState() =>
      _SplashPageState();


}





class _SplashPageState
    extends ConsumerState<SplashPage> {



  @override
  void initState(){

    super.initState();

    startApp();

  }







  Future<void> startApp() async {


    await Future.delayed(

      const Duration(
        seconds:3,
      ),

    );




    if(!mounted) return;




    final user =
    ref.read(authProvider);





    if(user != null){



      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>

          const InventorDashboardPage(),

        ),

      );


    }

    else{


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_)=>

          const LoginPage(),

        ),

      );


    }


  }








  @override
  Widget build(BuildContext context){


    return const Scaffold(

      body:

      Center(

        child:

        CircularProgressIndicator(),

      ),

    );


  }


}