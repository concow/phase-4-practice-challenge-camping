class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    activity = Activity.all
    render json: activity
  end

  def destroy
    # .find(id: params[:id]) did not work
    activity = Activity.find(params[:id])
    activity.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { error: "Activity not found" }, status: :not_found
  end

end