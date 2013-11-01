@app.controller "AllPlansController", ["$scope", '$notification', 'PlansFactory',
  ($scope, $notification, PlansFactory) ->

    $scope.planSelection = (plan) ->
      PlansFactory.get {id: plan.id}, (data)->
        $scope.selectedPlan = data["plan"]

]