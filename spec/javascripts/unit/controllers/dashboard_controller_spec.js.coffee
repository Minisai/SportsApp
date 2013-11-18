describe "DashboardController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  modalWindow = {
    modal: (action) ->
  }
  modalServiceMock = {
    showModal: (scope, modal_name) ->
  }
  player = {id: 1, name: 'name' }

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "DashboardController", $scope: scope, $notification: notification, BootstrapModalService: modalServiceMock
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(modalServiceMock, 'showModal')
    spyOn(modalWindow, 'modal')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  describe 'playerSelection', ->
    beforeEach ->
      httpMock.whenGET("players/#{player.id}").respond(player: player)
      scope.playerSelection(player.id)
      httpMock.flush()
    it 'should assign player data to scope.player', ->
      expect(scope.player).toEqual(player)
    it 'should switch showPlayerProfile to true', ->
      expect(scope.showPlayerProfile).toBe(true)

  describe 'sendMessage', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.send_message_modal = modalWindow
        scope.player = player
        httpMock.whenPOST("/coaches/players/#{player.id}/send_message").respond(message: 'success')
        scope.sendMessage()
        httpMock.flush()
      it 'should hide modal window', ->
        expect(modalWindow.modal).toHaveBeenCalledWith('hide');
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        scope.send_message_modal = modalWindow
        scope.player = player
        httpMock.whenPOST("/coaches/players/#{player.id}/send_message").respond(401, message: 'error')
        scope.sendMessage()
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'sendMotivation', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.motivation_modal = modalWindow
        scope.player = player
        httpMock.whenPOST("/coaches/players/#{player.id}/motivate").respond(motivations: ['motivation 1', 'motivation 2'], message: 'success')
        scope.sendMotivation()
        httpMock.flush()
      it 'should hide modal window', ->
        expect(modalWindow.modal).toHaveBeenCalledWith('hide');
      it 'should assign motivations data to scope.motivations', ->
        expect(scope.motivations).toEqual(['motivation 1', 'motivation 2']);
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'error request mock', ->
      beforeEach ->
        scope.send_message_modal = modalWindow
        scope.player = player
        httpMock.whenPOST("/coaches/players/#{player.id}/motivate").respond(401, message: 'error')
        scope.sendMotivation()
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();




