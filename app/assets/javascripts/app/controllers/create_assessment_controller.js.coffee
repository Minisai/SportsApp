@app.controller "CreateAssessmentController", ["$scope", '$notification', "DrillsFactory", 'AssessmentsFactory',
  ($scope, $notification, DrillsFactory, AssessmentsFactory) ->
    $scope.exercises = []
    $scope.assessment = {}

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

    $scope.createAssessment = ->
      @assessment['exercises_attributes'] = @exercises

      AssessmentsFactory.save({assessment: @assessment},
        (success_data) ->
          $scope.assessment = {}
          $scope.exercises = []
          $notification.success("Success", success_data['message'])
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))
]