describe "TeamsController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  new_team = {name: "New Team"}
  team = {name: 'Team 1', id: 1}
  player = {name: 'Player 1', id: 10}

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "TeamsController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  it 'should initialize filter variable', ->
    expect(scope.filter).toEqual {}

  describe 'createTeam', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.new_team = new_team
        httpMock.whenPOST("/coaches/teams").respond(teams: ['team 1', 'team 2'], message: 'success')
        scope.createTeam()
        httpMock.flush()
      it 'should clear new_team', ->
        expect(scope.new_team).toEqual({});
      it 'should assign teams data to scope.teams', ->
        expect(scope.teams).toEqual(['team 1', 'team 2']);
      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();
    describe 'error request mock', ->
      beforeEach ->
        scope.new_team = new_team
        httpMock.whenPOST("/coaches/teams").respond(401, message: 'error')
        scope.createTeam()
        httpMock.flush()
      it 'should not clear new_team', ->
        expect(scope.new_team).not.toEqual({});
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'teamPlayerRemoveClick', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.selected_team = team
        httpMock.whenDELETE("/coaches/teams/#{team.id}/players/#{player.id}").respond(players: ['player 1', 'player 2'], message: 'success')
        scope.teamPlayerRemoveClick(player)
        httpMock.flush()
      it 'should assign players data to scope.team_players', ->
        expect(scope.team_players).toEqual(['player 1', 'player 2']);
    describe 'error request mock', ->
      beforeEach ->
        scope.selected_team = team
        httpMock.whenDELETE("/coaches/teams/#{team.id}/players/#{player.id}").respond(401, message: 'error')
        scope.teamPlayerRemoveClick(player)
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'dropPlayerHandler', ->
    describe 'success request mock', ->
      beforeEach ->
        scope.selected_team = team
        scope.draggedPlayer = player
        httpMock.whenPOST("/coaches/teams/#{team.id}/players").respond(players: ['player 1', 'player 2'], message: 'success')
        scope.dropPlayerHandler()
        httpMock.flush()
      it 'should assign players data to scope.team_players', ->
        expect(scope.team_players).toEqual(['player 1', 'player 2']);
    describe 'error request mock', ->
      beforeEach ->
        scope.selected_team = team
        scope.draggedPlayer = player
        httpMock.whenPOST("/coaches/teams/#{team.id}/players").respond(401, message: 'error')
        scope.dropPlayerHandler()
        httpMock.flush()
      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

