import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ygpbanhmbenezhtmnxel.supabase.co',
    anonKey: 'sb_publishable_eG-0fDPRsyveX54qTlRq-Q_A_hLchEG',
  );
  runApp(App());
}