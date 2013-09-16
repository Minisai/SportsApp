@app.controller "TeamsController", ["$scope", "$notification", "TeamsFactory", "PlayersFactory",
  ($scope, $notification, TeamsFactory, PlayersFactory) ->
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
]
