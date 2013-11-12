describe "AllAssessmentController", ->
  beforeEach module("sports-app")
  scope = null
  httpMock = null
  default_assessment_id = 1
  assessment_id = 2

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "AllAssessmentController", $scope: scope
    httpMock = $httpBackend;
    httpMock.when("GET", "/coaches/assessments/#{default_assessment_id}").respond(assessment: "default_assessment_hash");
    httpMock.when("GET", "/coaches/assessments/#{assessment_id}").respond(assessment: "assessment_hash");
  )

  it "should initialize assessments", ->
    expect(scope.assessments).toEqual []

  describe 'defaultAssessmentSelection', ->
    beforeEach ->
      scope.defaultAssessmentSelection(default_assessment_id)
      httpMock.flush()

    it 'should assign defaultAssessment data to selectedDefaultAssessment', ->
      expect(scope.selectedDefaultAssessment).toBe("default_assessment_hash");
    it 'should nullify selectedAssessment', ->
      expect(scope.selectedAssessment).toBe(null);

  describe 'assessmentSelection', ->
    beforeEach ->
      scope.assessmentSelection(assessment_id)
      httpMock.flush()

    it 'should assign assessment data to selectedAssessment', ->
      expect(scope.selectedAssessment).toBe("assessment_hash");
    it 'should nullify selectedAssessment', ->
      expect(scope.selectedDefaultAssessment).toBe(null);

