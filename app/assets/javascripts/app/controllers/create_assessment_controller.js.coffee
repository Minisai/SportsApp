@app.controller "CreateAssessmentController", ["$scope", "DrillsFactory", ($scope, DrillsFactory) ->
  $scope.exercises = []

  $scope.drillSelection = (drill_id) ->
    DrillsFactory.get {id: drill_id}, (data) ->
      $scope.selectedDrill = data["drill"]

  $scope.dropDrillHandler = (event, ui) ->
    @exercises.push({
      drill_id: $scope.draggedDrill['id'],
      name: @draggedDrill['name'],
      repetitions: 1
    })

  $scope.dragDrillHandler = (event, ui, drill) ->
    $scope.draggedDrill = drill

  $scope.removeDrillClick = (index) ->
    @exercises.splice(index, 1)

  $scope.editRepetitions = (index, value) ->
    @exercises[index]['repetitions'] = value
]