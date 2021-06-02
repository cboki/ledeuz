class GamesController < ApplicationController
skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @games = policy_scope(Game)
  end

  def new
    @game = Game.new
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    authorize @game

    if @game.save
      redirect_to root_path, notice: 'La partie a bien été créée'
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:start_datetime)
  end
end
