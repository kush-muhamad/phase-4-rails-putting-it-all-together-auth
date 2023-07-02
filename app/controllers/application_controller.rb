class ApplicationController < ActionController::API
  include ActionController::Cookies
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
before_action :authorize

private

def authorize
  @current_user = User.find_by(id: session[:user_id])
  render json: { errors: ["Not authorized"] }, status: 401 unless @current_user
end

def render_unprocessable_entity_response(inavlid)
  render json: { errors: inavlid.record.errors.full_messages }, status: 422

end

end
