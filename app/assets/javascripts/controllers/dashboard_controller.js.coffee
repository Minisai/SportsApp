@app.controller "DashboardController", ($scope, PlayersFactory) ->
  $scope.lol = "LOL"
  $scope.playerSelection = (id) ->
    PlayersFactory.get {id: id}, (data)->
      $scope.player = data["player"]
      $scope.showPlayerProfile = true