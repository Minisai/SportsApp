@app.controller "DashboardController", ($scope, $http, PlayersFactory, BootstrapModalService, $notification) ->
  $scope.playerSelection = (id) ->
    PlayersFactory.get {id: id}, (data)->
      $scope.player = data["player"]
      $scope.showPlayerProfile = true

  $scope.sendMessage = ->
    $http.post("/coaches/players/#{@player.id}/send_message", {message: @message}
    ).success((data)->
        $scope.send_message_modal.modal('hide')
        $notification.success("Success", data['message'])
    ).error (data) ->
        $notification.error("Error", data['message'])

  $scope.showModal = (modalName) ->
    BootstrapModalService.showModal($scope, modalName)
