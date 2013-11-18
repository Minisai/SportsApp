describe "RewardsController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  defaultRewards = [ {id: 1, reward_image_id: 1, image_url:'url1'},
                     {id: 2, reward_image_id: 2, image_url:'url2'},
                     {id: 3, reward_image_id: 3, image_url:'url3'}]
  rewards = [ {id: 11, reward_image_id: null, image_url: null},
              {id: 12, reward_image_id: null, image_url: null},
              {id: 13, reward_image_id: null, image_url: null}]
  rewardImages = [ {id: 1, image_url:'url1'},
                   {id: 2, image_url:'url2'},
                   {id: 3, image_url:'url3'}]

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "RewardsController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  describe 'defaultRewardSelection', ->
    beforeEach ->
      scope.defaultRewards = defaultRewards
      scope.defaultRewardSelection(0)
    it 'should assign default_reward by index to scope.selectedDefaultReward', ->
      expect(scope.selectedDefaultReward).toEqual defaultRewards[0]
    it 'should nullify others variables', ->
      expect(scope.selectedReward).toBeNull()
      expect(scope.newReward).toBeNull()
      expect(scope.selectedRewardImage).toBeNull()

  describe 'rewardSelection', ->
    beforeEach ->
      scope.rewards = rewards
      scope.rewardSelection(0)
    it 'should assign reward by index to scope.selectedReward', ->
      expect(scope.selectedReward).toEqual rewards[0]
    it 'should nullify others variables', ->
      expect(scope.selectedDefaultReward).toBeNull()
      expect(scope.newReward).toBeNull()
      expect(scope.selectedRewardImage).toBeNull()

  describe 'createNewRewardClicked', ->
    beforeEach ->
      scope.createNewRewardClicked()
    it 'should initialize newReward', ->
      expect(scope.newReward).toEqual({})
    it 'should nullify others variables', ->
      expect(scope.selectedDefaultReward).toBeNull()
      expect(scope.selectedReward).toBeNull()
      expect(scope.selectedRewardImage).toBeNull()

  describe 'rewardImageSelection', ->
    describe 'scope.selectedReward present', ->
      beforeEach ->
        scope.rewardImages = rewardImages
        scope.selectedReward = rewards[0]
        scope.rewardImageSelection(0)
      it 'should update selectedReward reward_image_id', ->
        expect(scope.selectedReward.reward_image_id).toEqual rewardImages[0].id
      it 'should update selectedReward image_url', ->
        expect(scope.selectedReward.image_url).toEqual rewardImages[0].image_url

    describe 'scope.newReward present', ->
      beforeEach ->
        scope.rewardImages = rewardImages
        scope.newReward = {}
        scope.rewardImageSelection(0)
      it 'should update newReward reward_image_id', ->
        expect(scope.newReward.reward_image_id).toEqual rewardImages[0].id
      it 'should update newReward image_url', ->
        expect(scope.newReward.image_url).toEqual rewardImages[0].image_url

  describe 'createReward', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.newReward = rewards[0]
        httpMock.whenPOST("/coaches/rewards").respond(rewards: ['reward 1', 'reward 2'], message: 'success')
        scope.createReward()
        httpMock.flush()
      it 'should clear newReward', ->
        expect(scope.newReward).toEqual({});
      it 'should assign rewards data to scope.rewards', ->
        expect(scope.rewards).toEqual(['reward 1', 'reward 2']);
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        scope.newReward = rewards[0]
        httpMock.whenPOST("/coaches/rewards").respond(401, message: 'error')
        scope.createReward()
        httpMock.flush()
      it 'should not clear newReward', ->
        expect(scope.newReward).not.toEqual({});
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'updateReward', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.selectedReward = rewards[0]
        httpMock.whenPUT("/coaches/rewards/#{scope.selectedReward.id}").respond(rewards: ['reward 1', 'reward 2'], message: 'success')
        scope.updateReward()
        httpMock.flush()
      it 'should assign rewards data to scope.rewards', ->
        expect(scope.rewards).toEqual(['reward 1', 'reward 2']);
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        scope.selectedReward = rewards[0]
        httpMock.whenPUT("/coaches/rewards/#{scope.selectedReward.id}").respond(401, message: 'error')
        scope.updateReward()
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'removeReward', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.selectedReward = rewards[0]
        httpMock.whenDELETE("/coaches/rewards/#{scope.selectedReward.id}").respond(rewards: ['reward 1', 'reward 2'], message: 'success')
        scope.removeReward()
        httpMock.flush()
      it 'should clear selectedReward', ->
        expect(scope.selectedReward).toEqual(null);
      it 'should assign rewards data to scope.rewards', ->
        expect(scope.rewards).toEqual(['reward 1', 'reward 2']);
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        scope.selectedReward = rewards[0]
        httpMock.whenDELETE("/coaches/rewards/#{scope.selectedReward.id}").respond(401, message: 'error')
        scope.removeReward()
        httpMock.flush()
      it 'should not clear selectedReward', ->
        expect(scope.selectedReward).not.toEqual(null);
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'removeRewardImage', ->
    describe 'success request mock', ->
      beforeEach ->
        httpMock.whenDELETE("/coaches/reward_images/#{rewardImages[0].id}").respond(reward_images: ['reward_image 1', 'reward_image 2'], message: 'success')
        scope.removeRewardImage(rewardImages[0].id)
        httpMock.flush()
      it 'should assign reward_images data to scope.rewardImages', ->
        expect(scope.rewardImages).toEqual(['reward_image 1', 'reward_image 2']);
      it 'should not call $notification.success', ->
        expect(notification.success).not.toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        httpMock.whenDELETE("/coaches/reward_images/#{rewardImages[0].id}").respond(401, message: 'error')
        scope.removeRewardImage(rewardImages[0].id)
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();


