@app.controller "TeamsController", ["$scope", "$http", "$notification", "TeamsFactory", "PlayersFactory", "TeamsPlayersFactory", "BootstrapModalService"
  ($scope, $http, $notification, TeamsFactory, PlayersFactory, TeamsPlayersFactory, BootstrapModalService) ->
    $scope.filter = {}

    $scope.playersSearch= ->
      filter_params = {}
      filter_params['player_id'] = @filter.player_id unless typeof @filter.player_id  == "undefined"
      filter_params['last_name'] = @filter.last_name unless typeof @filter.last_name  == "undefined"
      filter_params['country'] = @filter.country unless typeof @filter.country  == "undefined"
      $scope.players = PlayersFactory.query(filter_params)

    $scope.teamSelection = (id) ->
      $scope.addNewTeamClicked = false

      if typeof $scope.selected_team  == "undefined"
        getTeamAndPlayers(id)
      else if $scope.selected_team.id != id
        getTeamAndPlayers(id)
      else
        $scope.selected_team = undefined

    getTeamAndPlayers = (id) ->
      $scope.selected_team = TeamsFactory.get {id: id}
      $scope.team_players = PlayersFactory.query( {team_id: id})

    $scope.addNewTeamClick = ->
      $scope.addNewTeamClicked = true
      $scope.selected_team = undefined

    $scope.createTeam = ->
      TeamsFactory.save(@new_team,
        (success_data) ->
          $scope.teams = success_data['teams']
          $notification.success("Success", success_data['message'])
        , (error_result) ->
          $notification.error("Error", error_result['data']['message']))

    $scope.teamPlayerRemoveClick = (selected_team_player) ->
      TeamsPlayersFactory.delete({team_id: @selected_team.id, id: selected_team_player.id},
        (success_data) ->
          $scope.team_players = success_data['players']
        , (error_result) ->
          $notification.error("Error", error_result['data']['message']))

    $scope.dropPlayerHandler = (event, ui) ->
      TeamsPlayersFactory.save({team_id: @selected_team.id, player_id: @draggedPlayer.id},
        (success_data) ->
          $scope.team_players = success_data['players']
        , (error_result) ->
          $notification.error("Error", error_result['data']['message']))

    $scope.dragPlayerHandler = (event, ui, player) ->
      $scope.draggedPlayer = player

    $scope.showAddPlayerModal = ->
      BootstrapModalService.showModal($scope, 'add_player_modal')

    $scope.invitePlayer = ->
      $http.post("/coaches/players/invite", {player: @new_player}
      ).success((data)->
        $scope.add_player_modal.modal('hide')
        $notification.success("Success", data['message'])
      ).error (data) ->
        $notification.error("Error", data['message'])
]
