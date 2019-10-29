require './test/test_helper'
require './lib/stat_tracker'
require './lib/season_module'

class SeasonModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal 0, @stat_tracker.biggest_bust('20122013')
  end

  def test_biggest_bust
    assert_equal 0, @stat_tracker.biggest_bust('20122013')
  end

  def test_winningest_coach
    assert_equal 'Peter Deboer', @stat_tracker.winningest_coach('20122013')
  end

  def test_worst_coach
    assert_equal 'John Tortorella', @stat_tracker.worst_coach('20122013')
  end

end