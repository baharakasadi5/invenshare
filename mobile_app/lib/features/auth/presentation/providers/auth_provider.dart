import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/user_model.dart';


// ===============================
// Hive Users Box Provider
// ===============================

final authBoxProvider = Provider<Box<UserModel>>((ref) {

  return Hive.box<UserModel>('users');

});




// ===============================
// Auth Notifier
// ===============================

class AuthNotifier extends StateNotifier<UserModel?> {


  final Box<UserModel> box;



  AuthNotifier(this.box) : super(null) {

    loadUser();

  }






  // ===============================
  // Load User From Hive
  // ===============================

  void loadUser() {


    if(box.isEmpty){

      state = null;

      return;

    }




    UserModel? savedUser;




    // اول currentUser را بخوان

    savedUser =
        box.get('currentUser');





    // اگر نبود اولین کاربر را پیدا کن

    if(savedUser == null){


      for(final user in box.values){


        savedUser = user;

        break;


      }


    }





    if(savedUser != null){


      state = savedUser;



      // دوباره currentUser را ذخیره کن

      box.put(
        'currentUser',
        savedUser,
      );



    }
    else{


      state = null;


    }


  }








  // ===============================
  // Check Username
  // ===============================

  bool usernameExists(
      String username
      ){

    return box.containsKey(username);

  }








  // ===============================
  // Login
  // ===============================

  Future<bool> login(

      String username,

      String password,

      ) async {



    final cleanUsername =
        username.trim();



    final cleanPassword =
        password.trim();






    for(final user in box.values){



      if(

      user.username.trim()
          ==
          cleanUsername

          &&

          user.password.trim()
              ==
              cleanPassword

      ){



        await box.put(

          'currentUser',

          user,

        );



        state = user;



        return true;


      }


    }




    return false;



  }









  // ===============================
  // Register
  // ===============================

  Future<String?> register(
      UserModel user
      ) async {



    final username =
        user.username.trim();



    final password =
        user.password.trim();





    if(username.isEmpty){

      return "Username cannot be empty";

    }




    if(password.length < 6){

      return "Password must be at least 6 characters";

    }




    if(usernameExists(username)){


      return "Username already exists";


    }





    final newUser =
        user.copyWith(

          username: username,

          password: password,

        );







    await box.put(

      username,

      newUser,

    );





    await box.put(

      'currentUser',

      newUser,

    );





    state = newUser;




    return null;


  }









  // ===============================
  // Update Profile
  // ===============================

  Future<void> updateProfile(

      UserModel updatedUser

      ) async {



    await box.put(

      updatedUser.username,

      updatedUser,

    );




    await box.put(

      'currentUser',

      updatedUser,

    );




    state = updatedUser;



  }








  // ===============================
  // Logout
  // ===============================

  Future<void> logout() async {


    await box.delete(

      'currentUser',

    );


    state = null;


  }








  // ===============================
  // Change Password
  // ===============================

  Future<String?> updatePassword(

      String newPassword

      ) async {



    if(state == null){

      return "No user logged in";

    }





    if(newPassword.length < 6){

      return "Password must be at least 6 characters";

    }






    final updatedUser =

    state!.copyWith(

      password: newPassword.trim(),

    );




    await updateProfile(updatedUser);
    return null;


  }








  // ===============================
  // Delete Account
  // ===============================

  Future<void> deleteAccount() async {


    if(state == null){

      return;

    }



    await box.delete(

      state!.username,

    );




    await box.delete(

      'currentUser',

    );




    state = null;


  }


}








// ===============================
// Auth Provider
// ===============================


final authProvider =

StateNotifierProvider<

    AuthNotifier,

    UserModel?

>(

        (ref){



      final box =

      ref.watch(

        authBoxProvider,

      );




      return AuthNotifier(box);



    }

);







// ===============================
// Current User Provider
// ===============================


final currentUserProvider =
Provider<UserModel?>((ref) {

  final box =
      ref.watch(authBoxProvider);


  return box.get(
    'currentUser',
  );


});