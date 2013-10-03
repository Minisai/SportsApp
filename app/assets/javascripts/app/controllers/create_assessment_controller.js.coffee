@app.controller "CreateAssessmentController", ["$scope", "DrillsFactory", ($scope, DrillsFactory) ->
  $scope.drillSelection = (drill_id) ->
    DrillsFactory.get {id: drill_id}, (data) ->
      $scope.selected_drill = data["drill"]
]