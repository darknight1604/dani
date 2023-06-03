import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  Future<GoogleSignInAccount?> loginWithGmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.email'
      ],
    );
    return await googleSignIn.signIn();
  }
}
