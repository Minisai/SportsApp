@app.controller "RewardsController", ["$scope", '$notification', 'RewardsFactory',
  ($scope, $notification, RewardsFactory) ->
    $scope.defaultRewardSelection = (default_reward_id) ->
      RewardsFactory.get {id: default_reward_id}, (data)->
        $scope.selectedDefaultReward = data["reward"]
    $scope.rewardSelection = (reward_id) ->
      RewardsFactory.get {id: reward_id}, (data)->
        $scope.selectedReward = data["reward"]


]