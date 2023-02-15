class User {
  var firstName;
  var lastName;
  var email;
  var address;
  var age;
  var username;
  var password;

  User(this.firstName, this.lastName, this.email, this.address, this.age,
      this.username, this.password);

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    address = json['address'];
    age = json['age'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'address': address,
        'age': age,
        'username': username,
        'password': password,
      };
}

 

// factory User.fromJson(Map<String,dynamic> json)=> _$UserFromJson(json);



// Map<String,dynamic> toJson() => _$UserToJson(this);





// }
