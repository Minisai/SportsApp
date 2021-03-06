@app.controller "CreateAssessmentController", ["$scope", '$notification', "DrillsFactory", 'AssessmentsFactory',
  ($scope, $notification, DrillsFactory, AssessmentsFactory) ->
    $scope.exercises = []
    $scope.assessment = {}

    $scope.drillSelection = (drill_id) ->
      DrillsFactory.get {id: drill_id}, (data) ->
        $scope.selectedDrill = data["drill"]

    $scope.dragDrillHandler = (event, ui, drill) ->
      $scope.draggedDrill = drill

    $scope.dropDrillHandler = (event, ui) ->
      $scope.exercises.push({
        drill_id: $scope.draggedDrill['id'],
        name: $scope.draggedDrill['name'],
        repetitions: 1
      })

    $scope.removeDrillClick = (index) ->
      $scope.exercises.splice(index, 1)

    $scope.editRepetitions = (index, value) ->
      $scope.exercises[index]['repetitions'] = value

    $scope.createAssessment = ->
      $scope.assessment['exercises_attributes'] = $scope.exercises

      AssessmentsFactory.save({assessment: $scope.assessment},
        (success_data) ->
          $scope.assessment = {}
          $scope.exercises = []
          $notification.success("Success", success_data['message'])
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))
]