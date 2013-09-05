@app.controller "DashboardController", ($scope, $http, PlayersFactory) ->
  $scope.playerSelection = (id) ->
    PlayersFactory.get {id: id}, (data)->
      $scope.player = data["player"]
      $scope.showPlayerProfile = true

  $scope.sendMessage = ->
    $http.post("/coaches/players/#{$scope.player.id}/send_message", {message: @message}).success(alert("LOL"));