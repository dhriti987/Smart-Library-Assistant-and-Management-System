import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/UI/Sign_in.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _playerController;
  @override
  void initState() {
    _playerController =
        VideoPlayerController.asset('assets/video/library_gif.mp4')
          ..initialize().then((_) {
            _playerController.play();
            _playerController.setLooping(true);
            setState(
              () {},
            );
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _playerController.value.size.width,
                height: _playerController.value.size.height,
                child: VideoPlayer(_playerController),
              ),
            ),
          ),
          // Center(child: Text('Hello')),
          SignIn(),
        ],
      ),
    );
  }
}
