
module TeamModule

  def team_info(team)
    team_obj = self.convert_team_id_to_obj(team)
    team_info = {
      'team_name' => team_obj.teamname,
      'team_id' => team_obj.team_id,
      'franchise_id' => team_obj.franchiseid,
      'abbreviation' => team_obj.abbreviation,
      'link' => team_obj.link
    }
    team_info
  end

  def best_season(team)
    self.generate_win_percentage_season(team).max_by{|season, pct| pct}[0]
  end

  def worst_season(team)
    self.generate_win_percentage_season(team).min_by{|season, pct| pct}[0]
  end

  def average_win_percentage(team)
    values = self.generate_win_percentage_season(team).values
    (values.reduce {|sum, num| sum + num}.to_f / values.length).round(2)
  end

  def most_goals_scored(team_lookup)
    goals = []
    team_goals = game_teams.reduce({}) do |acc, game_team|
      acc[team_lookup] =  goals << (game_team.team_id == team_lookup ? game_team.goals : 0)
      acc
    end
    team_goals.map { |k, v| v.max }.first
  end

  def fewest_goals_scored(team_lookup)
    goals = []
    team_goals = game_teams.reduce({}) do |acc, game_team|
      acc[team_lookup] =  goals << (game_team.team_id == team_lookup ? game_team.goals : 0)
      acc
    end
    team_goals.map { |k, v| v.min }.first
  end

  def favorite_opponent(team_lookup)
    team_plays = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_plays[game.home_team_id][game.away_team_id] += 1
      team_plays[game.away_team_id][game.home_team_id] += 1
    end
    team_wins = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_wins[game.home_team_id][game.away_team_id] += game.home_goals > game.away_goals ? 1 : 0
      team_wins[game.away_team_id][game.home_team_id] += game.away_goals > game.home_goals ? 1 : 0
    end
    result = team_wins[team_lookup].merge(team_plays[team_lookup]) do |key, oldval, newval|
      if newval == 0
        0
      else
        (oldval.to_f / newval.to_f).round(2)
      end
    end
    id = result.sort_by { |k, v| v }.last.first
    convert_ids_to_team_name(id)
  end

  def rival(team_lookup)
    team_plays = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_plays[game.home_team_id][game.away_team_id] += 1
      team_plays[game.away_team_id][game.home_team_id] += 1
    end
    team_wins = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_wins[game.home_team_id][game.away_team_id] += game.home_goals > game.away_goals ? 1 : 0
      team_wins[game.away_team_id][game.home_team_id] += game.away_goals > game.home_goals ? 1 : 0
    end
    result = team_wins[team_lookup].merge(team_plays[team_lookup]) do |key, oldval, newval|
      if newval == 0
        100
      else
        (oldval.to_f / newval.to_f).round(2)
      end
    end
    id = result.sort_by { |k, v| v }.first.first
    convert_ids_to_team_name(id)
  end

  def biggest_team_blowout id
    result = []
    games.each do |game|
      if game.away_team_id == id && game.away_goals > game.home_goals
        result << game.away_goals - game.home_goals
      elsif game.home_team_id == id && game.away_goals < game.home_goals
        result << game.home_goals - game.away_goals
      end
    end
    result.max
  end

  def worst_loss id
    result = []
    games.each do |game|
      if game.away_team_id == id && game.away_goals < game.home_goals
        result << game.home_goals - game.away_goals
      elsif game.home_team_id == id && game.away_goals > game.home_goals
        result << game.away_goals - game.home_goals
      end
    end
    result.max
  end


 #HELPER METHODS
  def empty_team_hash
    teams_hash = Hash.new
    teams.each {|team| teams_hash[team.team_id] = 0}
    teams_hash
  end

  def convert_ids_to_team_name(id)
    ids_to_name = teams.group_by {|team| team.team_id}.transform_values {|obj| obj[0].teamname}
    ids_to_name[id]
  end

  def generate_win_percentage_season(team)
     team_obj = self.convert_team_id_to_obj(team)
     games_by_team = game_teams.group_by {|game| game.team_id}
     by_season = games_by_team[team_obj.team_id].group_by do |game|
       season = find_season_game_id(game.game_id)
     end
     win_percent_season = by_season.transform_values do |val|
       (val.map {|game| game.result == 'WIN' ? 1 : 0}.reduce {|sum, num| sum + num}.to_f / val.length).round(2)
     end
     win_percent_season
  end

  def convert_team_id_to_obj(teamid)
    team_obj = teams.select {|team| team.team_id == teamid}[0]
  end

  def find_season_game_id(gameid)
    game = games.find {|gm| gm.game_id == gameid}
    game.season
  end
end
