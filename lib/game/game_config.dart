import 'package:flutter/material.dart';

import 'package:studio_core/app/arcade_stage.dart';
import 'package:studio_core/app/game_api.dart';
import 'package:studio_core/core/game_rules.dart';
import 'casual_engine.dart';
import 'casual_view.dart';
import 'rules.dart';

final gameConfig = GameConfig(
  gameId: 'game-099-tile-match-triple',
  title: const ['Üçlü Taş Eşleştir', 'Tile Match Triple', 'Kachel-Dreier', 'Triple de Fichas', 'Triple de Tuiles'],
  tagline: const ['Aynı üç taşı tepsiye al, tahtayı temizle!', 'Collect three of a kind and clear the board!', 'Drei gleiche sammeln!', '¡Junta tres iguales!', 'Réunissez trois pareils !'],
  seedColor: const Color(0xFF2D6A4F),
  icon: Icons.grid_view,
  rules: TileMatchRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => CasualSim((ctx.generated as GeneratedLevel<CasualLevel>).puzzle),
    paint: paintCasual,
    sound: casualSound,
    boosterIcon: Icons.undo,
    boosterLabel: (l) => l == 'tr' ? 'Geri al (3 taş)' : 'Undo (3 tiles)',
    howTo: const ['Karartılı olmayan taşa dokun; tepsiye gider. Aynı üç taş birleşince kaybolur.', 'Tap an uncovered tile to move it to the tray. Three of a kind vanish.', 'Freie Kachel antippen.', 'Toca una ficha libre.', 'Touchez une tuile libre.'],
  ),
  tutorial: const [
    TutorialStep(Icons.touch_app, ['Üstteki taşlara dokun.', 'Tap top tiles.', 'Obere Kacheln antippen.', 'Toca las de arriba.', 'Touchez celles du dessus.']),
    TutorialStep(Icons.view_week, ['Tepside üçü birleşince kaybolur.', 'Three alike in the tray vanish.', 'Drei gleiche verschwinden.', 'Tres iguales desaparecen.', 'Trois pareils disparaissent.']),
    TutorialStep(Icons.warning, ['Tepsiyi doldurma!', 'Do not fill the tray!', 'Ablage nicht füllen!', '¡No llenes la bandeja!', 'Ne remplissez pas le plateau !']),
  ],
);
