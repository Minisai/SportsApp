describe "AssignPlanController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  plan = { id: 1 }
  team = { id: 2 }
  player = { id: 3 }

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "AssignPlanController", $scope: scope
    httpMock = $httpBackend
  )

  it "should initialize assigneeTypes", ->
    expect(scope.assigneeTypes).toEqual ['Team', 'Player']

  describe 'dragPlanHandler', ->
    beforeEach ->
      scope.dragPlanHandler(null, null, plan)
    it 'should assign draggedPlan to selectedPlan', ->
      expect(scope.selectedPlan).toEqual(plan)

  describe 'dropPlanOnTeamHandler', ->
    beforeEach ->
      httpMock.whenPOST("/coaches/plans/#{plan.id}/teams").respond(teams: ['team1', 'team2', 'team3'])
      scope.selectedPlan = plan
      scope.dropPlanOnTeamHandler(null, null, team)
      httpMock.flush()

    it 'should assign teams data to teams', ->
      expect(scope.teams).toEqual(['team1', 'team2', 'team3'])

  describe 'dropPlanOnPlayerHandler', ->
    beforeEach ->
      httpMock.whenPOST("/coaches/plans/#{plan.id}/players").respond(players: ['player1', 'player2', 'player3'])
      scope.selectedPlan = plan
      scope.dropPlanOnPlayerHandler(null, null, player)
      httpMock.flush()

    it 'should assign teams data to teams', ->
      expect(scope.players).toEqual(['player1', 'player2', 'player3'])

  describe 'removeTeamPlan', ->
    beforeEach ->
      httpMock.whenDELETE("/coaches/plans/#{plan.id}/teams/#{team.id}").respond(teams: ['team1', 'team2'])
      scope.selectedPlan = plan
      scope.removeTeamPlan(team, plan)
      httpMock.flush()

    it 'should assign teams data to teams', ->
      expect(scope.teams).toEqual(['team1', 'team2'])

  describe 'removePlayerPlan', ->
    beforeEach ->
      httpMock.whenDELETE("/coaches/plans/#{plan.id}/players/#{player.id}").respond(players: ['player1', 'player2'])
      scope.selectedPlan = plan
      scope.removePlayerPlan(player, plan)
      httpMock.flush()

    it 'should assign teams data to teams', ->
      expect(scope.players).toEqual( ['player1', 'player2'])