require_relative 'api_controller'

module Api
  module V1
    class TeamsController < ApiController
      def index
        @teams = Team.includes(:matches).all
        json_response(@teams)
      end

      def create
        find_params = { sn1: params[:sn1] }
        find_params[:sn2] = params[:sn2].blank? ? params[:sn2] : nil

        @team = Team.find_or_initialize_by(find_params)

        unless @team.persisted?
          @team = Team.create!(team_params)
        end

        json_response(@team, :created)
      end

      def show
        @team = Team.includes(:matches).find(params[:id])
        json_response(@team)
      end

      def update
        @team = Team.find(params[:id])
        @team.update(team_params)
      end

      def destroy
        @team = Team.find(params[:id])
        @team.destroy
        head :no_content
      end

      private

      def team_params
        params.require(:team).permit(:name, :sn1, :sn2, :sn1_position, :sn2_position)
      end
    end
  end
end
