import 'package:flame/game.dart';
import 'package:flappy_bird/flappy_game.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlameU
  runApp(
    const GameWidget<FlappyGame>.controlled(
      gameFactory: FlappyGame.new,
    ),
  );
}
