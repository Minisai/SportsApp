@app.controller "AssignPlanController", ["$scope", '$notification', 'PlansFactory',
  ($scope, $notification, PlansFactory) ->
    $scope.assigneeTypes = ['Team', 'Player']

]