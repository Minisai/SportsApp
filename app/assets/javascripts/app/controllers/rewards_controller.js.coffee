@app.controller "RewardsController", ["$scope", '$http', '$notification', 'RewardsFactory', 'CoachesRewardsFactory', 'RewardImagesFactory'
  ($scope, $http, $notification, RewardsFactory, CoachesRewardsFactory, RewardImagesFactory) ->
    nullifyAllVariables = ->
      $scope.selectedDefaultReward = null
      $scope.selectedReward = null
      $scope.newReward = null
      $scope.selectedRewardImage = null

    $scope.defaultRewardSelection = (index) ->
      nullifyAllVariables()
      $scope.selectedDefaultReward = $scope.defaultRewards[index]

    $scope.rewardSelection = (index) ->
      nullifyAllVariables()
      $scope.selectedReward = angular.copy($scope.rewards[index])

    $scope.createNewRewardClicked = ->
      nullifyAllVariables()
      $scope.newReward = {}

    $scope.rewardImageSelection = (index) ->
      $scope.selectedRewardImage = $scope.rewardImages[index]
      if $scope.selectedReward
        $scope.selectedReward.image_url = $scope.selectedRewardImage.image_url
        $scope.selectedReward.reward_image_id = $scope.selectedRewardImage.id
      if $scope.newReward
        $scope.newReward.image_url = $scope.selectedRewardImage.image_url
        $scope.newReward.reward_image_id = $scope.selectedRewardImage.id

    $scope.checkName = (data) ->
      if (data.length == 0)
        return "Name should be present"

    $scope.createReward = ->
      CoachesRewardsFactory.save({reward: $scope.newReward},
      (success_data) ->
        $scope.rewards = success_data['rewards']
        $scope.newReward = {}
        $notification.success("Success", "Reward was created successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.updateReward = ->
      CoachesRewardsFactory.update({id: $scope.selectedReward.id, reward: $scope.selectedReward},
      (success_data) ->
        $scope.rewards = success_data['rewards']
        $notification.success("Success", "Reward was updated successfully")
      ,(error_result) ->
        $notification.error("Error", error_result['data']['message']))

    $scope.removeReward = ->
      if (confirm('Are you sure you want to delete reward?'))
        CoachesRewardsFactory.delete({id: $scope.selectedReward.id},
        (success_data) ->
          $scope.rewards = success_data['rewards']
          $scope.selectedReward = null
          $notification.success("Success", "Reward was deleted successfully")
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))

    $scope.onFileSelect = (files) ->
      file = files[0]
      $http.uploadFile(
        url: "/coaches/reward_images"
        file: file
      ).success((data) ->
        $scope.rewardImages = data['reward_images']
      ).error (data) ->
        $notification.error("Error", data['message'])

    $scope.removeRewardImage = (reward_image_id) ->
      if (confirm('Are you sure you want to delete image?'))
        RewardImagesFactory.delete({id: reward_image_id},
        (success_data) ->
          $scope.rewardImages = success_data['reward_images']
        ,(error_result) ->
          $notification.error("Error", error_result['data']['message']))

]