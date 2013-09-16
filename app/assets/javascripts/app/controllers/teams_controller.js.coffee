@app.controller "TeamsController", ["$scope", "$notification", "TeamsFactory", "PlayersFactory", "TeamsPlayersFactory",
  ($scope, $notification, TeamsFactory, PlayersFactory, TeamsPlayersFactory) ->
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
]
