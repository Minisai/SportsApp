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
    $scope.players = PlayersFactory.query()

  $scope.addNewTeamClick = ->
    $scope.addNewTeamClicked = true
    $scope.team = undefined

  $scope.createTeam = ->
    TeamsFactory.save(@new_team,
      (data) ->
        $notification.success("Success", data['message'])
      , (data) ->
        alert(data['message'])
        $notification.error("Error", data['message']))
