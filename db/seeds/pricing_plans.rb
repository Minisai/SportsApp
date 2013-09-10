names = ["Month subscription", "3 months subscription", "6 months subscription", "Year subscription"]

#Coach pricing plans
PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[0]
  pricing_plan.cost = 15
  pricing_plan.role_type = :coach
  pricing_plan.duration = 1
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[1]
  pricing_plan.cost = 40
  pricing_plan.role_type = :coach
  pricing_plan.duration = 3
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[2]
  pricing_plan.cost = 70
  pricing_plan.role_type = :coach
  pricing_plan.duration = 6
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[3]
  pricing_plan.cost = 120
  pricing_plan.role_type = :coach
  pricing_plan.duration = 12
end

#Player pricing plans
PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[0]
  pricing_plan.cost = 10
  pricing_plan.role_type = :player
  pricing_plan.duration = 1
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[1]
  pricing_plan.cost = 25
  pricing_plan.role_type = :player
  pricing_plan.duration = 3
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[2]
  pricing_plan.cost = 40
  pricing_plan.role_type = :player
  pricing_plan.duration = 6
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[3]
  pricing_plan.cost = 60
  pricing_plan.role_type = :player
  pricing_plan.duration = 12
end

#Parent pricing plans
PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[0]
  pricing_plan.cost = 10
  pricing_plan.role_type = :parent
  pricing_plan.duration = 1
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[1]
  pricing_plan.cost = 25
  pricing_plan.role_type = :parent
  pricing_plan.duration = 3
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[2]
  pricing_plan.cost = 40
  pricing_plan.role_type = :parent
  pricing_plan.duration = 6
end

PricingPlan.create do |pricing_plan|
  pricing_plan.name = names[3]
  pricing_plan.cost = 60
  pricing_plan.role_type = :parent
  pricing_plan.duration = 12
end
