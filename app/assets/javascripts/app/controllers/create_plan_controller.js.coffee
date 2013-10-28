@app.controller "CreatePlanController", ["$scope", '$notification', "DrillsFactory",
  ($scope, $notification, DrillsFactory) ->
    $scope.plan_items = []

    $scope.addSessionClick = ->
      $scope.plan_items.push({item_type: 'PlanSession', days: []})

    $scope.addAssessmentClick = ->
      $scope.plan_items.push({item_type: 'Assessment'})

    $scope.addRewardClick = ->
      $scope.plan_items.push({item_type: 'Reward'})

    $scope.planItemSelection = (plan_item) ->
      if plan_item.selected == true
        plan_item.selected = false
      else
        plan_item.selected = true

    $scope.addDayClick = (plan_item) ->
      plan_item.days.push({exercises: []})

    $scope.daySelection = (day) ->
      if day.selected == true
        day.selected = false
      else
        day.selected = true

    $scope.planItemUpClick = ->
      alert("UP")

    $scope.planItemDownClick = ->
      alert("DOWN")
]