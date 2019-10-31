require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_module'

class TeamModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture_2.csv'
    team_path = './data/teams_fixture_2.csv'
    game_teams_path = './data/game_teams_fixture_2.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_info
    skip
  end

  def test_best_season
    skip
  end

  def test_worst_season
    skip
  end

  def test_average_win_percentage
    skip
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored('1')
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored('2')
  end

  def test_favorite_opponent
    assert_equal "Seattle Sounders FC", @stat_tracker.favorite_opponent('4')
  end

  def test_rival
    assert_equal "Chicago Fire", @stat_tracker.rival('3')
  end

  def test_biggest_team_blowout
    assert_equal 2, @stat_tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 2, @stat_tracker.biggest_team_blowout("3")
  end

  def test_head_to_head
    skip
  end

  def test_seasonal_summary
    skip
  end

end
