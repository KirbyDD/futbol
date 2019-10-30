require 'pry'
module SeasonModule

  def biggest_bust(season_id)
    games_in_regular_season = games.find_all { |game| game.season == season_id && game.type == 'Regular Season'}
    games_in_post_season = games.find_all { |game| game.season == season_id && game.type == 'Postseason' }

    reg_hash = games_in_regular_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :reg_wins => 0, :reg_games => 0 }
      acc[game.away_team_id] = { :reg_wins => 0, :reg_games => 0 }
      acc
    end

    games_in_regular_season.map do |game|
      reg_hash[game.home_team_id][:reg_wins] += game.home_goals > game.away_goals ? 1 : 0
      reg_hash[game.away_team_id][:reg_wins] += game.away_goals > game.home_goals ? 1 : 0
      reg_hash[game.home_team_id][:reg_games] += 1
      reg_hash[game.away_team_id][:reg_games] += 1
    end

    post_hash = games_in_post_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :post_wins => 0, :post_games => 0 }
      acc[game.away_team_id] = { :post_wins => 0, :post_games => 0 }
      acc
    end

    games_in_post_season.map do |game|
      post_hash[game.home_team_id][:post_wins] += game.home_goals > game.away_goals ? 1 : 0
      post_hash[game.away_team_id][:post_wins] += game.away_goals > game.home_goals ? 1 : 0
      post_hash[game.home_team_id][:post_games] += 1
      post_hash[game.away_team_id][:post_games] += 1
    end

    reg_win_stats = reg_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:reg_wins].to_f / v[:reg_games].to_f)
      acc
    end

    post_win_stats = post_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:post_wins].to_f / v[:post_games].to_f)
      acc
    end

    results = reg_win_stats.merge(post_win_stats) do |key, oldval, newval|
        (oldval.to_f - newval.to_f).round(5)
    end

    id = results.sort_by { |k, v| v }.last.first
    convert_ids_to_team_name(id)
  end

  def biggest_surprise(season_id)
    games_in_regular_season = games.find_all { |game| game.season == season_id && game.type == 'Regular Season'}
    games_in_post_season = games.find_all { |game| game.season == season_id && game.type == 'Postseason' }

    reg_hash = games_in_regular_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :reg_wins => 0, :reg_games => 0 }
      acc[game.away_team_id] = { :reg_wins => 0, :reg_games => 0 }
      acc
    end

    games_in_regular_season.map do |game|
      reg_hash[game.home_team_id][:reg_wins] += game.home_goals > game.away_goals ? 1 : 0
      reg_hash[game.away_team_id][:reg_wins] += game.away_goals > game.home_goals ? 1 : 0
      reg_hash[game.home_team_id][:reg_games] += 1
      reg_hash[game.away_team_id][:reg_games] += 1
    end

    post_hash = games_in_post_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :post_wins => 0, :post_games => 0 }
      acc[game.away_team_id] = { :post_wins => 0, :post_games => 0 }
      acc
    end

    games_in_post_season.map do |game|
      post_hash[game.home_team_id][:post_wins] += game.home_goals > game.away_goals ? 1 : 0
      post_hash[game.away_team_id][:post_wins] += game.away_goals > game.home_goals ? 1 : 0
      post_hash[game.home_team_id][:post_games] += 1
      post_hash[game.away_team_id][:post_games] += 1
    end

    reg_win_stats = reg_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:reg_wins].to_f / v[:reg_games].to_f)
      acc
    end

    post_win_stats = post_hash.reduce({}) do |acc, (k, v)|
      acc[k] = (v[:post_wins].to_f / v[:post_games].to_f)
      acc
    end

    results = reg_win_stats.merge(post_win_stats) do |key, oldval, newval|
        (oldval.to_f - newval.to_f).round(5)
    end

    id = results.sort_by { |k, v| v }.first.first
    convert_ids_to_team_name(id)
  end

  def winningest_coach(season)
    best_team = self.team_records_by_season(season).max_by {|team, record| record}[0]
    self.find_coach(best_team.team_id, season)
  end

  def worst_coach(season)
    worst_team = self.team_records_by_season(season).min_by {|team, record| record}[0]
    self.find_coach(worst_team.team_id, season)
  end

  def most_accurate_team(season)

  end

  def least_accurate_team(season)

  end

  def most_tackles(season_id)
    games_in_season = games.find_all { |game| game.season == season_id }
    games = games_in_season.map { |game| game.game_id }

    tackles_hash = games_in_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :tackles => 0 }
      acc[game.away_team_id] = { :tackles => 0 }
      acc
    end

    game_teams.map do |game_team|
      if games.include?(game_team.game_id)
        tackles_hash[game_team.team_id][:tackles] += game_team.tackles.to_i
      end
    end

    id = tackles_hash.sort_by { |k, v| v[:tackles] }.last.first
    convert_ids_to_team_name(id)
  end

  def fewest_tackles(season_id)
    games_in_season = games.find_all { |game| game.season == season_id }
    games = games_in_season.map { |game| game.game_id }

    tackles_hash = games_in_season.reduce({}) do |acc, game|
      acc[game.home_team_id] = { :tackles => 0 }
      acc[game.away_team_id] = { :tackles => 0 }
      acc
    end

    game_teams.map do |game_team|
      if games.include?(game_team.game_id)
        tackles_hash[game_team.team_id][:tackles] += game_team.tackles.to_i
      end
    end

    id = tackles_hash.sort_by { |k, v| v[:tackles] }.first.first
    convert_ids_to_team_name(id)
  end

  #HELPER METHODS

  def team_records_by_season(season)
    records = Hash.new
    win_percent_season = teams.collect do |team|
      records[team] = self.generate_win_percentage_season(team.teamname).select do |sea, team|
        sea == season
      end.values[0]
    end
    records
  end

  def find_coach(team_id, season)
    games_played = self.find_games_in_season_team(team_id, season)
    games_played[0].head_coach
    #binding.pry
  end

  def find_games_in_season_team(team_id, season)
    games_in_season = game_teams.find_all do |game|
      self.find_season_game_id(game.game_id) == season
    end
    games_by_season_team = games_in_season.find_all {|game| game.team_id == team_id}
    #binding.pry
  end

  def accuracy_by_team

    

end
