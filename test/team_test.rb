require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_module'

class TeamModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)

    game_path = './data/games_fixture_2.csv'
    team_path = './data/teams_fixture_2.csv'
    game_teams_path = './data/game_teams_fixture_2.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker_2 = StatTracker.from_csv(locations)
  end

  def test_team_info
    team = {"team_name"=>"Atlanta United", "team_id"=>"1", "franchise_id"=>"23", "abbreviation"=>"ATL", "link"=>"/api/v1/teams/1"}
    assert_equal team, @stat_tracker.team_info('1')
  end

  def test_best_season
    assert_equal '20122013', @stat_tracker.best_season('2')
  end

  def test_worst_season
    assert_equal '20122013', @stat_tracker.best_season('2')
  end

  def test_avg_win_percentage
    assert_equal 0.43, @stat_tracker.average_win_percentage('2')
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker_2.most_goals_scored('1')
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker_2.fewest_goals_scored('2')
  end

  def test_favorite_opponent
    assert_equal "Seattle Sounders FC", @stat_tracker_2.favorite_opponent('4')
  end

  def test_rival
    assert_equal "Chicago Fire", @stat_tracker_2.rival('3')
  end

  def test_biggest_team_blowout
    assert_equal 2, @stat_tracker_2.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 2, @stat_tracker_2.biggest_team_blowout("3")
  end

  def test_head_to_head
    skip
  end

  def test_seasonal_summary
    skip
  end

end
