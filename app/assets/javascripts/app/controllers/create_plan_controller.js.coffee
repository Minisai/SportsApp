@app.controller "CreatePlanController", ["$scope", '$notification', "DrillsFactory",
  ($scope, $notification, DrillsFactory) ->
    $scope.planItems = []

    $scope.drillSelection = (drillId) ->
      DrillsFactory.get {id: drillId}, (data) ->
        $scope.selectedDrill = data["drill"]

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

    $scope.addSessionClick = ->
      $scope.planItems.push({itemType: 'PlanSession', days: []})
      calculateSessionNumbers()

    $scope.planItemSelection = (planItem) ->
      addOrRemoveSelectedFlag(planItem)

    $scope.addDayClick = (planItem) ->
      planItem.days.push({exercises: []})

    $scope.daySelection = (day) ->
      addOrRemoveSelectedFlag(day)

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
]

app.directive "tableSelect", ->
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