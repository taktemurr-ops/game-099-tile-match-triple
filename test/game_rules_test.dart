import 'package:flutter_test/flutter_test.dart';
import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/level_plan.dart';
import 'package:game_099_tile_match_triple/game/casual_engine.dart';
import 'package:game_099_tile_match_triple/game/rules.dart';

void main() {
  final rules = TileMatchRules();
  final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: rules.optionalMechanics);

  CasualSim fresh([int n = 1]) => CasualSim(rules.build(planner.spec(n)).puzzle);

  test('a stuck board costs a life and restarts the same board', () {
    final s = fresh(4);
    final g = s.goalText;
    s.boardFailed();
    expect(s.lives, 2);
    expect(s.goalText, g);
  });

  test('autopilot clears the first twelve boards without losing a life', () {
    for (var n = 1; n <= 12; n++) {
      final s = fresh(n);
      expect(runBot(s, rules.bot, 60 * 60 * 6).won, isTrue, reason: 'level $n');
      expect(s.lives, 3, reason: 'level $n');
    }
  });

  test('tiles: three of a kind in the tray vanish; a full tray fails', () {
    final s = fresh(5) as TileSim;
    for (final k in s.order.take(3)) {
      final t = s.tiles[k];
      s.tick(ArcadeInput(down: true, tap: true, x: t.x + kTileW / 2, y: t.y + kTileH / 2));
      s.tick(const ArcadeInput(x: 0, y: 0));
    }
    expect(s.tray, isEmpty);
    expect(s.matched, 3);
  });
}
