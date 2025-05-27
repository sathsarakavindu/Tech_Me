import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tec_me/test_page.dart';
import 'package:tec_me/view/pages/Technicians/technician_dashboard/dashboard_technician.dart';
import 'package:tec_me/view/pages/Users/dashboard/newDashboard.dart';
import 'package:tec_me/view/pages/Users/login/login.dart';
import 'package:tec_me/view_model/persistence/sharedPreferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xpprxhnhgxeiqaepmroo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhwcHJ4aG5oZ3hlaXFhZXBtcm9vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ4OTE1MTUsImV4cCI6MjA2MDQ2NzUxNX0.rH7LBY9ilNZpbkhfsRkHE4QbGMBuOMuxn4QSQRlZt-4',
  );
  // runApp(const MyApp());
  await isEmailAvailable();
}

Future<void> isEmailAvailable() async {
  final preferences = PersistenceHelper();
  String email = await preferences.getEmail();
  print(email);
  if (email.isNotEmpty) {
    if (await preferences.getAccountType() == "Technician") {
      runApp(
        const VerifiedTechnicianDashboard(),
      );
    } else {
      runApp(
        const VerifiedUserDashboard(),
      );
    }
  } else {
    runApp(
      const MyApp(),
    );
  }
}

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    );
  }
}

class VerifiedTechnicianDashboard extends StatelessWidget {
  const VerifiedTechnicianDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DashboardTechnician(),
    );
  }
}

class VerifiedUserDashboard extends StatelessWidget {
  const VerifiedUserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DashboardNew(),
    );
  }
}
