@app.controller "CreatePlanController", ["$scope", '$notification', "DrillsFactory",
  ($scope, $notification, DrillsFactory) ->
    $scope.plan_items = []

    $scope.drillSelection = (drill_id) ->
      DrillsFactory.get {id: drill_id}, (data) ->
        $scope.selectedDrill = data["drill"]

    addOrRemoveSelectedFlag = (object) ->
      if object.selected == true
        object.selected = false
      else
        object.selected = true

    calculateSessionNumbers = ->
      i = 1
      for plan_item in $scope.plan_items
        if plan_item.item_type == 'PlanSession'
          plan_item.name = "Session " + i
          i++

    $scope.addSessionClick = ->
      $scope.plan_items.push({item_type: 'PlanSession', days: []})
      calculateSessionNumbers()

    $scope.addAssessmentClick = ->
      $scope.plan_items.push({item_type: 'Assessment', name: 'New  Assessment'})

    $scope.addRewardClick = ->
      $scope.plan_items.push({item_type: 'Reward', name: 'New Reward'})

    $scope.planItemSelection = (plan_item) ->
      addOrRemoveSelectedFlag(plan_item)

    $scope.addDayClick = (plan_item) ->
      plan_item.days.push({exercises: []})

    $scope.daySelection = (day) ->
      addOrRemoveSelectedFlag(day)

    $scope.planItemUpClick = (index) ->
      if index > 0
        plan_item = $scope.plan_items.splice(index, 1)[0]
        $scope.plan_items.splice(index-1, 0, plan_item)
        calculateSessionNumbers() if plan_item.item_type == 'PlanSession'

    $scope.planItemDownClick = (index) ->
      if index < $scope.plan_items.length
        plan_item = $scope.plan_items.splice(index, 1)[0]
        $scope.plan_items.splice(index+1, 0, plan_item)
        calculateSessionNumbers() if plan_item.item_type == 'PlanSession'

    $scope.planItemRemoveClick = (index) ->
      deleted_plan_item = $scope.plan_items.splice(index, 1)[0]
      calculateSessionNumbers() if deleted_plan_item.item_type == 'PlanSession'
]

app.directive "tableSelect", ->
  replace: true
  templateUrl: "/angular/templates/table_select.html"
  scope:
    items: "="
    selected: "="

  link: (scope) ->
    scope.selectItem = (item) ->
      scope.selected = item