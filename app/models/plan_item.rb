class PlanItem < ActiveRecord::Base
  validates :item, :presence => true
  belongs_to :item, :polymorphic => true
  belongs_to :plan

  after_destroy :destroy_plan_session

  class << self
    def build_from(plan_items_params)
      result = []
      if plan_items_params.present?
        plan_items_params.each_with_index do |item_params, index|
          result << if item_params[:item_type].in? ['Assessment', 'Reward']
            item = item_params[:item_type].constantize.find_by_id(item_params[:id])
            { :item => item, :position => index }
          elsif item_params[:item_type] == 'PlanSession'
            plan_session = PlanSession.create(:days_attributes => item_params[:days_attributes] || [])
            { :item => plan_session, :position => index }
          else
            {}
          end
        end
      end
      result
    end
  end

  private

  def destroy_plan_session
    if item_type == 'PlanSession'
      item.destroy
    end
  end
end
