class GetVehicles {
  String username;
  String email;
  String contact_no;
  String nic;
  String image_url;
  String vehicle_no;
  String model;
  String type;
  String color;
  

  GetVehicles(
      {required this.username,
      required this.email,
      required this.contact_no,
      required this.nic,
      required this.image_url,
      required this.vehicle_no,
      required this.model,
      required this.type,
      required this.color});

  factory GetVehicles.fromJson(Map<String, dynamic> vehicleData) {
  
    return GetVehicles(
      username: vehicleData['name'],
      email: vehicleData['email'],
      contact_no: vehicleData['contact_no'],
      nic: vehicleData['nic'],
      image_url: vehicleData['image_url'],
      vehicle_no: vehicleData['vehicle_no'],
      model: vehicleData['model'],
      type: vehicleData['type'],
      color: vehicleData['color'],
    );
  }
}
