import 'package:bank_app/routes/app_routes.dart';
import 'package:bank_app/shared/repositories/firebase_options.dart';
import 'package:flutter/material.dart';
import 'styles/color_schemes.g.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.watch(AppRoutes.router);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // routeInformationParser: router.routeInformationParser,
      // routeInformationProvider: router.routeInformationProvider,
      // routerDelegate: router.routerDelegate,
      routerConfig: router,
    );
  }

  static void disposeProviders() {}
}
