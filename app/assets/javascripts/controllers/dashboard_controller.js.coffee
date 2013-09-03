@app.controller "DashboardController", ($scope, PlayersFactory) ->
  $scope.playerSelection = (id) ->
    $scope.player = PlayersFactory.get({id: id})