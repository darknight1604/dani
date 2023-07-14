import 'package:dani/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flame/game.dart';
import 'package:flappy/flappy_game.dart';
import 'package:flutter/material.dart';
import 'package:dani/core/utils/extensions/text_style_extension.dart';
import '../../../core/utils/text_theme_util.dart';

class FlappyScreen extends StatelessWidget {
  const FlappyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.flappy_gameName),
          style: TextThemeUtil.instance.titleMedium?.semiBold
              .copyWith(color: Colors.white),
        ),
      ),
      body: GameWidget<FlappyGame>.controlled(
        gameFactory: FlappyGame.new,
        loadingBuilder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
