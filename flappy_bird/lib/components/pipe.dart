import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';

import '../flappy_game.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyGame> {
  // This variable is position of Pipe
  final Vector2 pipeBodyPosition;
  final double pipeHeight;

  Pipe(this.pipeBodyPosition, {required this.pipeHeight})
      : assert(pipeBodyPosition.y == 0, 'pipeBodyPosition must has y by zero');

  final double spaceBetweenPipes = 100;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    List<Image> listResource = await Future.wait([
      game.images.load('pipe_body.png'),
      game.images.load('pipe_head.png'),
    ]);
    Image pipeBodyImage = listResource[0];
    Image pipeHeadImage = listResource[1];
    pipeBodyImage = await pipeBodyImage.resize(
      Vector2(pipeBodyImage.width.toDouble(), pipeHeight),
    );
    final imageComp = ImageComposition()
      ..add(
        pipeBodyImage,
        Vector2(pipeBodyPosition.x, 0),
      )
      ..add(
        pipeHeadImage,
        Vector2(pipeBodyPosition.x, pipeHeight),
      );
    Image image = await imageComp.compose();
    sprite = Sprite(image);
    position = pipeBodyPosition;
  }
}
