module MayBeDefaultConcern
  extend ActiveSupport::Concern

  included do
    scope :default, -> { where(:creator_type => 'Admin') }
    scope :default_or_for_coach, -> (coach) {  where("creator_type = 'Admin' OR (creator_type = 'Coach' AND creator_id = ?)", coach.id) }
  end
end