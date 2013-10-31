@app.controller "AssignPlanController", ["$scope", '$notification', 'PlansFactory',
  ($scope, $notification, PlansFactory) ->
    $scope.assigneeTypes = ['Team', 'Player']
    $scope.droppedPlan = {}

    $scope.dragPlanHandler = (plan) ->
      $scope.selectedPlan = plan

    $scope.dropPlanHandler = (assignee) ->
      alert("DROP")
]