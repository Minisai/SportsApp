@app.controller "AssignPlanController", ["$scope", '$notification', 'PlansFactory', 'PlansTeamsFactory', 'PlansPlayersFactory'
  ($scope, $notification, PlansFactory, PlansTeamsFactory, PlansPlayersFactory) ->
    $scope.assigneeTypes = ['Team', 'Player']
    $scope.droppedPlan = {}

    $scope.dragPlanHandler = (event, ui, plan) ->
      $scope.selectedPlan = plan

    $scope.dropPlanOnTeamHandler = (event, ui, team) ->
      PlansTeamsFactory.save({plan_id: $scope.selectedPlan.id, team_id: team.id},
      (success_data) ->
        $scope.teams = success_data['teams'])

    $scope.dropPlanOnPlayerHandler = (event, ui, player) ->
      PlansPlayersFactory.save({plan_id: $scope.selectedPlan.id, player_id: player.id},
      (success_data) ->
        $scope.players = success_data['players'])

    $scope.removeTeamPlan = (team, plan) ->
      PlansTeamsFactory.delete({plan_id: plan.id, id: team.id},
      (success_data) ->
        $scope.teams = success_data['teams'])

    $scope.removePlayerPlan = (player, plan) ->
      PlansPlayersFactory.delete({plan_id: plan.id, id: player.id},
      (success_data) ->
        $scope.players = success_data['players'])
]