@app.controller "AllPlansController", ["$scope", '$notification', 'PlansFactory',
  ($scope, $notification, PlansFactory) ->
    calculateSessionNumbers = (plan) ->
      i = 1
      for plan_item in plan.plan_items
        if plan_item.item_type == 'PlanSession'
          plan_item.item.name = "Session " + i
          i++

    $scope.planSelection = (plan, defaultPlanSelected=false) ->
      PlansFactory.get {id: plan.id}, (data)->
        $scope.selectedPlan = data["plan"]
        $scope.defaultPlanSelected = defaultPlanSelected
        calculateSessionNumbers($scope.selectedPlan)

    $scope.removePlan = ->
      if (confirm('Are you sure you want to delete plan?'))
        PlansFactory.delete({id: $scope.selectedPlan.id},
        (success_data) ->
          $scope.plans = success_data['plans']
          $scope.selectedPlan = null
          $notification.success("Success", "Plan was deleted successfully")
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))

]