@app.controller "CreatePlanController", ["$scope", '$notification', 'PlansFactory'
  ($scope, $notification, PlansFactory) ->

    $scope.planItems = []
    $scope.droppedDrill = {}

    addOrRemoveSelectedFlag = (object) ->
      if object.selected == true
        object.selected = false
      else
        object.selected = true

    calculateSessionNumbers = ->
      i = 1
      for planItem in $scope.planItems
        if planItem.itemType == 'PlanSession'
          planItem.name = "Session " + i
          i++

    # For plan items
    $scope.addSessionClick = ->
      $scope.planItems.push({itemType: 'PlanSession', days: []})
      calculateSessionNumbers()

    $scope.planItemSelection = (planItem) ->
      addOrRemoveSelectedFlag(planItem)

    $scope.planItemUpClick = (index) ->
      if index > 0
        planItem = $scope.planItems.splice(index, 1)[0]
        $scope.planItems.splice(index-1, 0, planItem)
        calculateSessionNumbers() if planItem.itemType == 'PlanSession'

    $scope.planItemDownClick = (index) ->
      if index < $scope.planItems.length
        planItem = $scope.planItems.splice(index, 1)[0]
        $scope.planItems.splice(index+1, 0, planItem)
        calculateSessionNumbers() if planItem.itemType == 'PlanSession'

    $scope.planItemRemoveClick = (index) ->
      deletedPlanItem = $scope.planItems.splice(index, 1)[0]
      calculateSessionNumbers() if deletedPlanItem.itemType == 'PlanSession'

    # For days
    $scope.addDayClick = (planItem) ->
      planItem.days.push({exercises: []})

    $scope.daySelection = (day) ->
      addOrRemoveSelectedFlag(day)

    $scope.dayUpClick = (planItem, index) ->
      if index > 0
        day = planItem.days.splice(index, 1)[0]
        planItem.days.splice(index-1, 0, day)

    $scope.dayDownClick = (planItem, index) ->
      if index < planItem.days.length
        day = planItem.days.splice(index, 1)[0]
        planItem.days.splice(index+1, 0, day)

    $scope.dayRemoveClick = (planItem, index) ->
      planItem.days.splice(index, 1)[0]

    # For drills
    $scope.drillSelection = (drill) ->
      $scope.selectedDrill = drill

    $scope.dragDrillHandler = (event, ui, drill) ->
      $scope.draggedDrill = drill

    $scope.dropDrillHandler = (event, ui, plan_item_index, day_index) ->
      $scope.planItems[plan_item_index].days[day_index].exercises.push({
        drillId: $scope.draggedDrill.id,
        name: $scope.draggedDrill.name,
        repetitions: 1
      })

    $scope.removeDrillClick = (day, index) ->
      day.exercises.splice(index, 1)

    $scope.createPlan = ->
      plan = {}
      plan['plan_item_attributes'] = $scope.planItems
      PlansFactory.save({plan: plan},
        (success_data) ->
          $scope.plan_items = []
          $notification.success("Success", success_data['message'])
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))
]

@app.directive "tableSelect", ->
  replace: false
  templateUrl: "/angular/templates/table_select.html"
  scope:
    items: "="
    selected: "="
    itemType: "="
    planItems: "="
  link: (scope) ->
    scope.selectItem = ->
      scope.selectedPlanItem.itemType = scope.itemType
      scope.planItems.push(scope.selectedPlanItem)
      scope.selectedPlanItem = null