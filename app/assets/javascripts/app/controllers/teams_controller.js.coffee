@app.controller "TeamsController", ($scope, $notification, TeamsFactory, PlayersFactory) ->
  $scope.teamSelection = (id) ->
    $scope.addNewTeamClicked = false

    if typeof $scope.team  == "undefined"
      getTeamAndPlayers(id)
    else if $scope.team.id != id
      getTeamAndPlayers(id)
    else
      $scope.team = undefined

  getTeamAndPlayers = (id) ->
    $scope.team = TeamsFactory.get {id: id}
    $scope.players = PlayersFactory.query( {team_id: id})

  $scope.addNewTeamClick = ->
    $scope.addNewTeamClicked = true
    $scope.team = undefined

  $scope.createTeam = ->
    TeamsFactory.save(@new_team,
      (success_data) ->
        $notification.success("Success", success_data['message'])
      , (error_result) ->
        $notification.error("Error", error_result['data']['message']))
