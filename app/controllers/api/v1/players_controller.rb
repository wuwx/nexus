require_relative 'api_controller'

module Api::V1
  class PlayersController < ApiController
    def index
      @players = Player.all
      json_response(@players)
    end

    def create
      @player = Player.create!(player_params)
      json_response(@player, :created)
    end

    def show
      @player = Player.find_by_name!(params[:name])
      json_response(@player)
    end

    def update
      @player = Player.find_by_name!(params[:name])
      if @player.update(player_params)
        head :no_content
      end
    end

    def destroy
      @player = Player.find_by_name!(params[:name])
      @player.destroy
      head :no_content
    end

    private

    def player_params
      params.require(:player).permit(
          :name, :email, :password, :password_confirmation,
          :avatar, :display_name, :rating, :sn
      )
    end
  end
end
