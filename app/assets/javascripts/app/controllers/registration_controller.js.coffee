@app.controller "RegistrationController", ["$scope", ($scope) ->
  $scope.datepicker = date: new Date("2000-09-01")
  $scope.roleTypes =
    Player: 'Player'
    Coach: 'Coach'
    Parent: 'Parent'
]
