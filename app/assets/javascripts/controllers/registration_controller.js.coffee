@app.controller "RegistrationController", ($scope) ->
  $scope.datepicker = date: new Date("2012-09-01T00:00:00.000Z")
  $scope.roleTypes =
    'Player': 'Player'
    'Coach': 'Coach'
    'Parent': 'Parent'
