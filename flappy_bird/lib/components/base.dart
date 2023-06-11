import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flappy_bird/flappy_game.dart';

class Base extends SpriteComponent with HasGameRef<FlappyGame> {
  final Vector2 screenSize;
  final Vector2 velocity = Vector2.zero();
  final double offset;

  Base(this.screenSize, this.offset);

  @override
  void onLoad() {
    super.onLoad();
    Image image = game.images.fromCache('base.png');
    sprite = Sprite(image);
    position = Vector2(offset, screenSize.y - image.height);
    size = Vector2(screenSize.x, image.size.y);
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position -= velocity * dt;
    if (position.x <= -size.x) {
      removeFromParent();
    }
    super.update(dt);
  }
}
