require 'csv'

<<<<<<< HEAD:lib/game.rb

class Game
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link
  #redundant?
  @@games = []
=======
class Games < Teams
  attr_reader :game_id, :season, :type, :date_time, :away_team_id, :home_team_id, :away_goals, :home_goals, :venue, :venue_link
>>>>>>> 236c5765973f3290f6f87164b7e3195f87521c75:lib/games.rb

  def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
    @venue_link = venue_link
  end

  def self.games

  end

  def self.create(file_path)
    @games = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
<<<<<<< HEAD:lib/game.rb
      binding.pry
      @@games << self.new(row[:game_id],
=======
      @games << self.new(row[:game_id],
>>>>>>> 236c5765973f3290f6f87164b7e3195f87521c75:lib/games.rb
                                    row[:season],
                                    row[:type],
                                    row[:date_time],
                                    row[:away_team_id],
                                    row[:home_team_id],
                                    row[:away_goals].to_i,
                                    row[:home_goals].to_i,
                                    row[:venue],
                                    row[:venue_link])
    end
    @games
  end

  def highest_total_score
    games.max_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    games.min_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def biggest_blowout
    games.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end
end

