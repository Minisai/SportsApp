@app.controller "AllPlansController", ["$scope", '$notification', 'PlansFactory',
  ($scope, $notification, PlansFactory) ->
    calculateSessionNumbers = (plan) ->
      i = 1
      for plan_item in plan.plan_items
        if plan_item.item_type == 'PlanSession'
          plan_item.item.name = "Session " + i
          i++

    $scope.planSelection = (plan) ->
      PlansFactory.get {id: plan.id}, (data)->
        $scope.selectedPlan = data["plan"]
        calculateSessionNumbers($scope.selectedPlan)

]