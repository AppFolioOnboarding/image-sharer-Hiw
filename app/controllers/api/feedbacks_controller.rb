module Api
  class FeedbacksController < ApplicationController
    def create
      error = validate_form(feedback_params)
      return_json = error ? { error: error, status: 'error' } : { status: 'success' }

      render status: error ? :bad_request : :ok, json: return_json
    end

    private

    def feedback_params
      params.require(:feedback).permit(:name, :comments)
    end

    def validate_form(params)
      return 'Name cannot be empty' if !params.key?(:name) || params[:name].strip.empty?
      return 'Comments cannot be empty' if !params.key?(:comments) || params[:comments].strip.empty?
    end
  end
end
