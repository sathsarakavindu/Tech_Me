class User {
  String email;
  String password;

  User({required this.email, required this.password});

  User get getUser => User(
    email: this.email,
    password: this.password,
  );


  
}
