class LoginRequestModel {
   String email;
   String password;

   LoginRequestModel({
    required this.email,
    required this.password
});

   Map<String,dynamic> toJson(){
      return{
        'email':email,
        'password':password
      };
 }

}

class LoginResponseModel{
   String token;

  LoginResponseModel({required this.token});

  factory LoginResponseModel.fromJson(Map<String,dynamic> json){
         return LoginResponseModel(
             token: json['token']as String
         );
  }
}