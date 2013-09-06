class Coach < ActiveRecord::Base
  include RoleConcern

  has_many :players
  has_many :teams
  has_many :motivations, :dependent => :destroy

  def find_or_create_motivation(motivation_params)
    if motivation_params[:id] == 'new'
      motivations.find_or_create_by(:message => motivation_params[:message])
    else
      motivations.find_by_id(motivation_params[:id])
    end
  end
end
