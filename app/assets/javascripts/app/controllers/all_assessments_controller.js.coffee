@app.controller "AllAssessmentController", ["$scope", '$notification', "DrillsFactory", 'AssessmentsFactory',
  ($scope, $notification, DrillsFactory, AssessmentsFactory) ->
    $scope.assessments = []

    $scope.defaultAssessmentSelection = (assessment_id) ->
      AssessmentsFactory.get {id: assessment_id}, (data)->
        $scope.selectedDefaultAssessment = data["assessment"]
        $scope.selectedAssessment = null

    $scope.assessmentSelection = (assessment_id) ->
      AssessmentsFactory.get {id: assessment_id}, (data)->
        $scope.selectedAssessment = data["assessment"]
        $scope.selectedDefaultAssessment = null

    $scope.checkName = (data) ->
      if (data.length == 0)
        return "Name should be present"

    $scope.updateAssessment = ->
      $scope.selectedAssessment['exercises_attributes'] = $scope.selectedAssessment['exercises']
      AssessmentsFactory.update({id: $scope.selectedAssessment.id, assessment: $scope.selectedAssessment},
      (success_data) ->
        $scope.assessments = success_data['assessments']
        $notification.success("Success", "Assessment was updated successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.removeAssessment = ->
      if (confirm('Are you sure you want to delete assessment?'))
        AssessmentsFactory.delete({id: $scope.selectedAssessment.id},
        (success_data) ->
          $scope.assessments = success_data['assessments']
          $scope.selectedAssessment = null
          $notification.success("Success", "Assessment was deleted successfully")
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))
]