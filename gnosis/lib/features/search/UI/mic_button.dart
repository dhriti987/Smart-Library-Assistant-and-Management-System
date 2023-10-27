import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/search/bloc/search_bloc.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MicButton extends StatefulWidget {
  const MicButton({super.key});

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  String _text = '';
  final SpeechToText _speech = SpeechToText();
  double confidence = 1.0;
  bool available = false;
  final FlutterTts flutterTts = FlutterTts();
  late SearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = sl.get<SearchBloc>();
    _initSpeech();
    super.initState();
  }

  void _initSpeech() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await _speech.initialize(
      debugLogging: true,
      onStatus: (status) {
        print("status");
        if (status == 'done' && _text.isNotEmpty) {
          print(_text+ "done");
          searchBloc.add(MicInputQueryResolveSearchEvent(searchQuery: _text));
        }
        searchBloc.add(SearchMicStateChangeEvent());
      },
    );
    searchBloc.add(SearchMicStateChangeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listenWhen: (previous, current) => current is SearchActionState,
      buildWhen: (previous, current) => current is! SearchActionState,
      bloc: searchBloc,
      listener: (context, state) {
        if(state is MicButtonClickedState){
          _speech.isNotListening ? _startListening() : _stopListening();
        }
        if(state is DisplayBookListResultWithReply){
          _speak(state.reply);
          context.pushNamed('BookList',extra: state.books, pathParameters: {'title': state.title});
        }
        if(state is DisplayBookResultWithReply){
          _speak(state.reply);
          context.push("/book_description", extra: state.books);
        }
        if(state is NoBookFoundStateWithReply){
          _speak(state.reply);
        }
      },
      builder: (context, state) {
        return AvatarGlow(
          glowColor: Theme.of(context).primaryColor,
          animate: _speech.isListening,
          endRadius: 60,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 70, 162, 237),
            onPressed:()=> searchBloc.add(SearchMicButtonOnClickedEvent()),
            child: Icon(_speech.isListening ? Icons.mic : Icons.mic_none),
          ),
        );
      },
    );
  }

  void _startListening() async {
    await _speech.listen(
      listenFor: const Duration(seconds: 5),
      onResult: (result) {
        _text = result.recognizedWords;
        if (result.hasConfidenceRating && result.confidence > 0) {
          confidence = result.confidence;
        }
      },
    );
    searchBloc.add(SearchMicStateChangeEvent());
  }

  void _stopListening() async {
    await _speech.stop();
    searchBloc.add(SearchMicStateChangeEvent());
  }

  Future _speak(text) async {
    await flutterTts.speak(text);
    _text = "";
  }
}
