@app.controller "AssignPlanController", ["$scope", 'PlansFactory', 'PlansTeamsFactory', 'PlansPlayersFactory'
  ($scope, PlansFactory, PlansTeamsFactory, PlansPlayersFactory) ->
    $scope.assigneeTypes = ['Team', 'Player']
    $scope.droppedPlan = {}

    $scope.dragPlanHandler = (event, ui, plan) ->
      $scope.selectedPlan = plan

    $scope.dropPlanOnTeamHandler = (event, ui, team) ->
      PlansTeamsFactory.save({plan_id: $scope.selectedPlan.id, team_id: team.id},
      (success_data) ->
        $scope.teams = success_data['teams']
      ,(error_result) ->
        $notification.error("Error", 'Error occured'))

    $scope.dropPlanOnPlayerHandler = (event, ui, player) ->
      PlansPlayersFactory.save({plan_id: $scope.selectedPlan.id, player_id: player.id},
      (success_data) ->
        $scope.players = success_data['players']
      ,(error_result) ->
        $notification.error("Error", 'Error occured'))

    $scope.removeTeamPlan = (team, plan) ->
      PlansTeamsFactory.delete({plan_id: plan.id, id: team.id},
      (success_data) ->
        $scope.teams = success_data['teams']
      ,(error_result) ->
        $notification.error("Error", 'Error occured'))

    $scope.removePlayerPlan = (player, plan) ->
      PlansPlayersFactory.delete({plan_id: plan.id, id: player.id},
      (success_data) ->
        $scope.players = success_data['players']
      ,(error_result) ->
        $notification.error("Error", 'Error occured'))
]