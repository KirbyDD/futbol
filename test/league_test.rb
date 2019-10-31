require './test/test_helper'
require './lib/stat_tracker'

class LeagueModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_count_of_teams
    assert_equal 3, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Seattle Sounders FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Atlanta United", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Seattle Sounders FC", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Houston Dynamo", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "Seattle Sounders FC", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Atlanta United", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_home_team
  end


  def test_winningest_team
    assert_equal "Atlanta United", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "Houston Dynamo", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Atlanta United"], @stat_tracker.worst_fans
  end

  def test_convert_ids_to_team_name
    assert_equal "Houston Dynamo", @stat_tracker.convert_ids_to_team_name("3")
  end
end
