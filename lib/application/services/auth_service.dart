class AuthService {
  bool isLoggedIn = false;

  Future<void> login() async {
    await Future.delayed(Duration(seconds: 1));
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }
}
