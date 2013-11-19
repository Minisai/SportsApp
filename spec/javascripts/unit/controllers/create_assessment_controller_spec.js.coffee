describe "CreateAssessmentController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  invalid_drill_id = 2
  drill = {id: 1, name: 'Drill'}

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "CreateAssessmentController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  it "should initialize exercises", ->
    expect(scope.exercises).toEqual []
  it "should initialize assessment", ->
    expect(scope.assessment).toEqual {}

  describe 'drillSelection', ->
    describe 'existed drill', ->
      beforeEach ->
        httpMock.whenGET("/drills/#{drill.id}").respond(drill: "drill_hash")
        scope.drillSelection(drill.id)
        httpMock.flush()
      it 'should assign drill data to selectedDrill', ->
        expect(scope.selectedDrill).toBe("drill_hash")

    describe 'invalid drill', ->
      beforeEach ->
        httpMock.whenGET("/drills/#{invalid_drill_id}").respond(401)
        scope.drillSelection(invalid_drill_id)
        httpMock.flush()
      it 'should nullify selectedDrill', ->
        expect(scope.selectedDrill).toBeUndefined()

  describe 'dragDrillHandler', ->
    beforeEach ->
      scope.dragDrillHandler(null, null, drill)
    it 'should assign passed drill to draggedDrill', ->
      expect(scope.draggedDrill).toEqual(drill)

  describe 'dropDrillHandler', ->
    beforeEach ->
      scope.draggedDrill = drill
      scope.dropDrillHandler(null, null)
    it 'should add exercise with draggedDrill', ->
      expect(scope.exercises).toEqual([{drill_id: drill.id, name: drill.name, repetitions: 1}])

  describe 'removeDrillClick', ->
    beforeEach ->
      scope.exercises = [ {drill_id: 1, name: 'Drill 1', repetitions: 1},
                          {drill_id: 2, name: 'Drill 2', repetitions: 1},
                          {drill_id: 3, name: 'Drill 3', repetitions: 1}]
      scope.removeDrillClick(1)
    it 'should remove exercise from scope.exercises by index', ->
      expect(scope.exercises).toEqual([ {drill_id: 1, name: 'Drill 1', repetitions: 1},
                                        {drill_id: 3, name: 'Drill 3', repetitions: 1}])

  describe 'editRepetitions', ->
    beforeEach ->
      scope.exercises = [{drill_id: 1, name: 'Drill 1', repetitions: 1}]
      scope.editRepetitions(0, 666)
    it 'should modify exercise repetitions count to passed value', ->
      expect(scope.exercises).toEqual([{drill_id: 1, name: 'Drill 1', repetitions: 666}])

  describe 'createAssessment', ->
    describe 'valid params mock', ->
      beforeEach ->
        httpMock.whenPOST("/coaches/assessments").respond(assessments: ["assessment1", "assessment2"])
        scope.exercises = [{drill_id: 1, name: 'Drill 1', repetitions: 1}]
        scope.assessment = {name: 'assessment 1'}
        scope.createAssessment()
        httpMock.flush()

      it 'should clear form', ->
        expect(scope.exercises).toEqual([])
        expect(scope.assessment).toEqual({})

      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'invalid params mock', ->
      beforeEach ->
        httpMock.whenPOST("/coaches/assessments").respond(403, message: 'error')
        scope.createAssessment()
        httpMock.flush()

      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();