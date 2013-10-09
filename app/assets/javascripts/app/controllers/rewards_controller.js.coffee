@app.controller "RewardsController", ["$scope", '$http', '$notification', 'RewardsFactory', 'CoachesRewardsFactory',
  ($scope, $http, $notification, RewardsFactory, CoachesRewardsFactory) ->
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

    $scope.checkName = (data) ->
      if (data.length == 0)
        return "Name should be present"

    $scope.createReward = ->
      CoachesRewardsFactory.save({reward: @newReward},
      (success_data) ->
        $scope.rewards = success_data['rewards']
        $scope.newReward = {}
        $notification.success("Success", "Reward was created successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.updateReward = ->
      CoachesRewardsFactory.update({id: @selectedReward.id, reward: @selectedReward},
      (success_data) ->
        $scope.rewards = success_data['rewards']
        $notification.success("Success", "Reward was updated successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.removeReward = ->
      if (confirm('Are you sure you want to delete reward?'))
        CoachesRewardsFactory.delete({id: @selectedReward.id},
        (success_data) ->
          $scope.rewards = success_data['rewards']
          $scope.selectedReward = null
          $notification.success("Success", "Reward was deleted successfully")
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))
]