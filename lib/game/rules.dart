import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/level_plan.dart';
import 'package:studio_core/core/missions.dart';
import 'package:studio_core/core/stats.dart';
import 'casual_engine.dart';

class TileMatchRules extends ArcadeRules<CasualLevel> {
  @override
  String get gameId => 'game-099-tile-match-triple';

  @override
  List<String> get optionalMechanics => const [];

  @override
  List<GameStat> get gameStats => const [
        GameStat('tiles_matched', 'Eşlenen taş', 'Tiles matched', scale: 3000),
        GameStat('boards_cleared', 'Bitirilen tahta', 'Boards cleared', scale: 40),
      ];

  @override
  List<MissionTemplate> get missionTemplates => const [
        MissionTemplate('tiles_matched', 'tiles_matched', [750, 1500, 3000]),
        MissionTemplate('boards_cleared', 'boards_cleared', [5, 10, 20], coinReward: 80),
      ];

  @override
  CasualLevel generate(LevelSpec spec) => generateCasual(CasualKind.tile, spec);

  @override
  ArcadeMeta metaOf(CasualLevel l) => l.meta;

  @override
  ArcadeSim createSim(CasualLevel l) => CasualSim(l);

  @override
  ArcadeInput bot(ArcadeSim sim) => casualBot(sim);
}

ArcadeRules createRules() => TileMatchRules();
