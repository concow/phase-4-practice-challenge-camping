class CampersController < ApplicationController
    # with an invalid ID: returns error message, returns appropriate status code
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # with invalid ID: does not create new camper, returns error message/status consider_all_requests_local
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index 
        camper = Camper.all
        render json: camper
    end

    def show   
        camper = Camper.find(params[:id])
        render json: camper
        # render json: camper, serializer: CamperWithActivitiesSerializer  #returns the matching camper with their associated activities
    end

    def create      
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end

