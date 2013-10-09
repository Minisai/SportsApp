@app.controller "AllAssessmentController", ["$scope", '$notification', "DrillsFactory", 'AssessmentsFactory',
  ($scope, $notification, DrillsFactory, AssessmentsFactory) ->
    $scope.assessments = []
    $scope.assessmentSelection = (assessment_id) ->
      AssessmentsFactory.get {id: assessment_id}, (data)->
          $scope.selectedAssessment = data["assessment"]

    $scope.checkName = (data) ->
      if (data.length == 0)
        return "Username should be present"

    $scope.updateAssessment = ->
      @selectedAssessment['exercises_attributes'] = @selectedAssessment['exercises']
      AssessmentsFactory.update({id: @selectedAssessment.id, assessment: @selectedAssessment},
      (success_data) ->
        $scope.assessments = success_data['assessments']
        $notification.success("Success", "Assessment was updated successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.removeAssessment = ->
      if (confirm('Are you sure you want to delete assessment?'))
        AssessmentsFactory.delete({id: @selectedAssessment.id},
        (success_data) ->
          $scope.assessments = success_data['assessments']
          $scope.selectedAssessment = null
          $notification.success("Success", "Assessment was deleted successfully")
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))

]