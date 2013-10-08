@app.controller "RewardsController", ["$scope", '$notification', 'RewardsFactory',
  ($scope, $notification, RewardsFactory) ->
    $scope.defaultRewardSelection = (index) ->
      $scope.selectedDefaultReward = $scope.defaultRewards[index]
      $scope.selectedReward = null
      $scope.newReward = null

    $scope.rewardSelection = (index) ->
      $scope.selectedReward = $scope.rewards[index]
      $scope.selectedDefaultReward = null
      $scope.newReward = null

    $scope.createNewRewardClicked = ->
      $scope.newReward = {}
      $scope.selectedReward = null
      $scope.selectedDefaultReward = null
]