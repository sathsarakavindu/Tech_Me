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
      user_name: help_list['user_name'],
      email: help_list['email'],
      vehicle_no: help_list['vehicle_no'],
      model: help_list['model'],
      type: help_list['type'],
      color: help_list['color'],
      nic: help_list['nic'],
      contact_no: help_list['contact_no'],
      address: help_list['address'],
      image_link: help_list['vehicle_image'],
      latitude: help_list['latitude'],
      longitude: help_list['longitude'],
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
