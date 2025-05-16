import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tec_me/test_page.dart';
import 'package:tec_me/view/pages/add_vehicle_page/add_vehicle.dart';
import 'package:tec_me/view/pages/dashboard/dashboard.dart';
import 'package:tec_me/view/pages/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/edit_vehicle_page/edit_vehicle_page.dart';
import 'package:tec_me/view/pages/history/history_technician.dart';
import 'package:tec_me/view/pages/login/login.dart';
import 'package:tec_me/view/pages/change_password/change_password.dart';
import 'package:tec_me/view/pages/user_account_page.dart/user_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xpprxhnhgxeiqaepmroo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwcHJ4aG5oZ3hlaXFhZXBtcm9vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ4OTE1MTUsImV4cCI6MjA2MDQ2NzUxNX0.rH7LBY9ilNZpbkhfsRkHE4QbGMBuOMuxn4QSQRlZt-4',
  );
  runApp(const MyApp());
}

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(),
      // home: ChangePassword(),
    );
  }
}
