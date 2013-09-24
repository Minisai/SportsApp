class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :prevent_invalid_role_type, :only => [:create]

  def new
    @user = User.new
  end

  def create
    role = build_role_from_params
    if role.save
      sign_in(:user, role.user)
      redirect_to :root, :flash => {:success => "You was successfully registered!"}
    else
      @user = role.user
      render 'new'
    end
  end

  private
  def role_params
    params.permit(:role_type, :program_code, :user => [:first_name, :last_name, :email, :username,
                  :password, :password_confirmation, :gender, :birthday, :country])
  end

  def build_role_from_params
    params = {:user_attributes => role_params[:user]}
    params.merge!({:program_code => role_params[:program_code]}) if role_params[:role_type].downcase == "player"

    role_params[:role_type].classify.constantize.new(params)
  end

  def prevent_invalid_role_type
    unless User::ROLE_TYPES.include?(role_params[:role_type].try(:downcase))
      @user = User.new(role_params[:user])
      flash[:alert] = 'Invalid account type'
      render 'new'
    end
  end
end