class ApplicationController < ActionController::API
  PAGE_PER = 20
  include AbstractController::Translation

  def arr_to_str_converter(sym)
    symbols = %i[sym]
    symbols.each{ |s|
      params[s] = params[s].join(',') if params.key?(s)
    }
  end

  def pagenate(resources, page = 1)
    paginated_resources = resources.order(created_at: :desc).page(page).per(PAGE_PER)
    paginated_resources
  end
  # before_action :authenticate_user_from_token!

  # respond_to :json

  # ##
  # # User Authentication
  # # Authenticates the user with OAuth2 Resource Owner Password Credentials
  # def authenticate_user_from_token!
  #   auth_token = request.headers['Authorization']

  #   if auth_token
  #     authenticate_with_auth_token auth_token
  #   else
  #     authenticate_error
  #   end
  # end

  # private

  # def authenticate_with_auth_token auth_token
  #   unless auth_token.include?(':')
  #     authenticate_error
  #     return
  #   end

  #   user_id = auth_token.split(':').first
  #   user = User.where(id: user_id).first

  #   if user && Devise.secure_compare(user.access_token, auth_token)
  #     # User can access
  #     sign_in user, store: false
  #   else
  #     authenticate_error
  #   end
  # end

  # ##
  # # Authentication Failure
  # # Renders a 401 error
  # def authenticate_error
  #   render json: { error: t('devise.failure.unauthenticated') }, status: 401
  # end
end
