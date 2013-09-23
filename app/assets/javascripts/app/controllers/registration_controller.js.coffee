@app.controller "RegistrationController", ["$scope", ($scope) ->
  $scope.datepicker = date: new Date("2000-09-01T00:00:00.000Z")
  $scope.roleTypes =
    'Player': 'Player'
    'Coach': 'Coach'
    'Parent': 'Parent'
]
