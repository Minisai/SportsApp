class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :prevent_invalid_role_type, :only => [:create]

  def new
    @user = User.new
  end

  def create
    role = build_role_from_params(find_coach_if_player)
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
    params.permit(:role_type, :program_code, :user => [:name, :email, :username,
                  :password, :password_confirmation, :gender, :birthday, :country])
  end

  def build_role_from_params(extra_params={})
    role_params[:role_type].classify.constantize.new({:user_attributes => role_params[:user]}.merge(extra_params))
  end

  def find_coach_if_player
    if role_params[:role_type].downcase == "player"
      {:coach => Coach.find_by_program_code(role_params[:program_code])}
    else
      {}
    end
  end

  def prevent_invalid_role_type
    unless User::ROLE_TYPES.include?(role_params[:role_type].try(:downcase))
      @user = User.new(role_params[:user])
      flash[:alert] = 'Invalid account type'
      render 'new'
    end
  end
end