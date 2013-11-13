describe "AllAssessmentController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  default_assessment_id = 1
  assessment_id = 2

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "AllAssessmentController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  it "should initialize assessments", ->
    expect(scope.assessments).toEqual []

  describe 'defaultAssessmentSelection', ->
    beforeEach ->
      httpMock.whenGET("/coaches/assessments/#{default_assessment_id}").respond(assessment: "default_assessment_hash")
      scope.defaultAssessmentSelection(default_assessment_id)
      httpMock.flush()

    it 'should assign defaultAssessment data to selectedDefaultAssessment', ->
      expect(scope.selectedDefaultAssessment).toBe("default_assessment_hash")
    it 'should nullify selectedAssessment', ->
      expect(scope.selectedAssessment).toBeNull()

  describe 'assessmentSelection', ->
    beforeEach ->
      httpMock.whenGET("/coaches/assessments/#{assessment_id}").respond(assessment: "assessment_hash")
      scope.assessmentSelection(assessment_id)
      httpMock.flush()

    it 'should assign assessment data to selectedAssessment', ->
      expect(scope.selectedAssessment).toBe("assessment_hash")
    it 'should nullify selectedAssessment', ->
      expect(scope.selectedDefaultAssessment).toBeNull()

  describe 'checkName', ->
    describe 'when data is blank', ->
      data = ''
      it 'should return validation text', ->
        expect(scope.checkName(data)).toBe("Name should be present")

    describe 'when data is present', ->
      data = 'name'
      it 'should return nothin', ->
        expect(scope.checkName(data)).toBeUndefined()

  describe 'updateAssessment', ->
    describe 'valid params mock', ->
      beforeEach ->
        httpMock.whenPUT("/coaches/assessments/#{assessment_id}").respond(assessments: ["assessment1", "assessment2"])
        scope.selectedAssessment = {id: assessment_id}
        scope.updateAssessment()
        httpMock.flush()

      it 'should assign responded assessments to scope.assessment', ->
        expect(scope.assessments).toEqual(["assessment1", "assessment2"])

      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'invalid params mock', ->
      beforeEach ->
        httpMock.whenPUT("/coaches/assessments/#{assessment_id}").respond(403, message: 'error')
        scope.selectedAssessment = {id: assessment_id}
        scope.updateAssessment()
        httpMock.flush()

      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();

  describe 'removeAssessment', ->
    describe 'valid params mock', ->
      beforeEach ->
        httpMock.whenDELETE("/coaches/assessments/#{assessment_id}").respond(assessments: ["assessment1", "assessment2"])
        scope.selectedAssessment = {id: assessment_id}
        scope.removeAssessment()
        httpMock.flush()

      it 'should assign responded assessments to scope.assessment', ->
        expect(scope.assessments).toEqual(["assessment1", "assessment2"])

      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'invalid params mock', ->
      beforeEach ->
        httpMock.whenDELETE("/coaches/assessments/#{assessment_id}").respond(403, message: 'error')
        scope.selectedAssessment = {id: assessment_id}
        scope.removeAssessment()
        httpMock.flush()

      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();