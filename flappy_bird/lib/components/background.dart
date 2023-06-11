import 'dart:ui';

import 'package:flame/components.dart';

import '../flappy_game.dart';

class Background extends SpriteAnimationComponent with HasGameRef<FlappyGame> {
  final Vector2 screenSize;

  late Sprite sprite;
  late Rect rect;
  Background(this.screenSize) {
    rect = Rect.fromLTWH(0, 0, screenSize.x, screenSize.y);
  }

  @override
  void onLoad() {
    super.onLoad();
    Image image = game.images.fromCache('background.png');
    sprite = Sprite(image);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    sprite.renderRect(canvas, rect);
  }
}
