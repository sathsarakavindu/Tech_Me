class Register {
 final String? name;
 final String? email;
 final String? password;
 final String? contact_no;
 final String? nic;
 final String? address;
 final String? account_type;

  Register({
    required this.name,
    required this.email,
    required this.password,
    required this.contact_no,
    required this.nic,
    required this.address,
    required this.account_type,
  });
  factory Register.fromJson(Map<String, dynamic> register_json){
    return Register(
      name: register_json[''], 
    email: register_json[''], 
    password: register_json[''], 
    contact_no: register_json[''], 
    nic: register_json[''], 
    address: register_json[''], 
    account_type: register_json[''],
    );
  }
}
