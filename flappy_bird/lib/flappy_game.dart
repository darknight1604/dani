import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';

import 'components/base.dart';
import 'components/pipe.dart';

class FlappyGame extends FlameGame {
  final world = World();
  late final CameraComponent cameraComponent;
  late Background background;
  late Base base;
  double objectSpeed = 150;

  @override
  void onLoad() async {
    super.onLoad();
    await images.loadAll([
      'background.png',
      'base.png',
      'downflap.png',
      'message.png',
      'midflap.png',
      'pipe_body.png',
      'pipe_head.png',
      'upflap.png',
    ]);
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;

    _initialWorld();

    addAll([
      cameraComponent,
      world,
    ]);
  }

  void _initialWorld() {
    base = Base(canvasSize, 0.0);
    background = Background(canvasSize);

    world.addAll([
      background,
      ..._createBase(),
      Pipe(Vector2(30, 0), pipeHeight: 150),
      Pipe(Vector2(150, 0), pipeHeight: 50),
      Pipe(Vector2(100, 0), pipeHeight: 75),
      // Pipe(Vector2(150, 30)),
    ]);
  }

  @override
  void update(double dt) {
    List<Base> listBase = world.children.whereType<Base>().toList();
    if (listBase.length < 2) {
      world.removeWhere((component) => component is Base);
      world.addAll(
        _createBase(),
      );
    }
    super.update(dt);
  }

  List<Base> _createBase() => [
        Base(canvasSize, 0.0),
        Base(canvasSize, canvasSize.x),
      ];
}
