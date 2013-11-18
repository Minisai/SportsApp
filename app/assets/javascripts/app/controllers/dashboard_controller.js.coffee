@app.controller "DashboardController", ["$scope", "$http", "PlayersFactory", "MotivationsFactory", "BootstrapModalService", "$notification",
  ($scope, $http, PlayersFactory, MotivationsFactory, BootstrapModalService, $notification) ->
    $scope.playerSelection = (id) ->
      PlayersFactory.get {id: id}, (data)->
        $scope.player = data["player"]
        $scope.showPlayerProfile = true

    $scope.showMessageModal = ->
      BootstrapModalService.showModal($scope, 'send_message_modal')

    $scope.sendMessage = ->
      $http.post("/coaches/players/#{$scope.player.id}/send_message", {message: $scope.message}
      ).success((data)->
          $scope.send_message_modal.modal('hide')
          $notification.success("Success", data['message'])
      ).error (data) ->
          $notification.error("Error", data['message'])

    $scope.showMotivationModal = ->
      $scope.motivations = MotivationsFactory.query()
      BootstrapModalService.showModal($scope, 'motivation_modal')

    $scope.sendMotivation = ->
      $http.post("/coaches/players/#{$scope.player.id}/motivate", {motivation: $scope.motivation}
      ).success((data) ->
        $scope.motivations = data['motivations']
        $scope.motivation_modal.modal('hide')
        $notification.success("Success", data['message'])
      ).error (data) ->
        $notification.error("Error", data['message'])
]