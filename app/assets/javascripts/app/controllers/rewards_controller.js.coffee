@app.controller "RewardsController", ["$scope", '$http', '$notification', 'RewardsFactory',
  ($scope, $http, $notification, RewardsFactory) ->
    $scope.defaultRewardSelection = (index) ->
      $scope.selectedDefaultReward = $scope.defaultRewards[index]
      $scope.selectedReward = null
      $scope.newReward = null
      $scope.selectedRewardImage = null

    $scope.rewardSelection = (index) ->
      $scope.selectedReward = angular.copy($scope.rewards[index])
      $scope.selectedDefaultReward = null
      $scope.newReward = null
      $scope.selectedRewardImage = null

    $scope.createNewRewardClicked = ->
      $scope.newReward = {}
      $scope.selectedReward = null
      $scope.selectedDefaultReward = null
      $scope.selectedRewardImage = null

    $scope.rewardImageSelection = (index) ->
      $scope.selectedRewardImage = $scope.rewardImages[index]
      if @selectedReward
        @selectedReward.image_url = @selectedRewardImage.image_url
        @selectedReward.reward_image_id = @selectedRewardImage.id
      if @newReward
        @newReward.image_url = @selectedRewardImage.image_url
        @newReward.reward_image_id = @selectedRewardImage.id

    $scope.onFileSelect = (files) ->
      file = files[0]
      $http.uploadFile(
        url: "/coaches/reward_images"
        file: file
      ).success((data) ->
        $scope.rewardImages = data['reward_images']
      ).error (data) ->
        $notification.error("Error", data['message'])

]