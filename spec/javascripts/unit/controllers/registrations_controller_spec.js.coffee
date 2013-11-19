describe "RegistrationController", ->
  beforeEach ->
    module("sports-app")
  scope = null

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "RegistrationController", $scope: scope
  )

  it 'should initialize roleTypes', ->
    expect(scope.roleTypes).toEqual({'Player': 'Player', 'Coach': 'Coach', 'Parent': 'Parent'})
  it 'should initialize datepicker', ->
    expect(scope.datepicker).toEqual(date: new Date("2000-09-01T00:00:00.000Z"))
