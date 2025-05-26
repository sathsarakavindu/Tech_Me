class MakeHelp {
  String user_name;
  String email;
  String vehicle_no;
  String model;
  String type;
  String color;
  String nic;
  String contact_no;
  String address;
  String image_link;
  double latitude;
  double longitude;

  MakeHelp({
    required this.user_name,
    required this.email,
    required this.vehicle_no,
    required this.model,
    required this.type,
    required this.color,
    required this.nic,
    required this.contact_no,
    required this.address,
    required this.image_link,
    required this.latitude,
    required this.longitude,
  });

  factory MakeHelp.fromJson(Map<String, dynamic> help_list) {
    return MakeHelp(
      user_name: help_list[''],
      email: help_list[''],
      vehicle_no: help_list[''],
      model: help_list[''],
      type: help_list[''],
      color: help_list[''],
      nic: help_list[''],
      contact_no: help_list[''],
      address: help_list[''],
      image_link: help_list[''],
      latitude: help_list[''],
      longitude: help_list[''],
    );
  }

  // MakeHelp getHelp() {
  //   return MakeHelp(
  //     user_name: user_name,
  //     email: email,
  //     vehicle_no: vehicle_no,
  //     model: model,
  //     type: type,
  //     color: color,
  //     nic: nic,
  //     contact_no: contact_no,
  //     address: address,
  //     latitude: latitude,
  //     longitude: longitude,
  //   );
  // }
}
