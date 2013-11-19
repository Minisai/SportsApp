describe "AllPlansController", ->
  beforeEach ->
    module("sports-app")
  scope = null
  httpMock = null
  notification = {
    error: ->
    success: ->
  }
  plan = { id: 1, plan_items: [ {item_type: 'PlanSession',  item: {}                },
                                {item_type: 'Reward',       item: {name: 'Reward 1'}},
                                {item_type: 'PlanSession',  item: {}                } ] }

  calculated_plan = { id: 1, plan_items: [ {item_type: 'PlanSession',  item: {name: 'Session 1'}},
                                           {item_type: 'Reward',       item: {name: 'Reward 1'}},
                                           {item_type: 'PlanSession',  item: {name: 'Session 2'}} ] }

  beforeEach inject(($rootScope, $controller, $httpBackend) ->
    scope = $rootScope.$new()
    $controller "AllPlansController", $scope: scope, $notification: notification
    spyOn(notification, 'success')
    spyOn(notification, 'error')
    spyOn(window, 'confirm').andReturn(true)
    httpMock = $httpBackend
  )

  describe 'planSelection', ->
    beforeEach ->
      httpMock.whenGET("/coaches/plans/#{plan.id}").respond(plan: plan)
      scope.planSelection(plan)
      httpMock.flush()

    it 'should assign plan data with calculated session names to selectedPlan', ->
      expect(scope.selectedPlan).toEqual(calculated_plan)
    it 'should falsify defaultPlanSelected', ->
      expect(scope.defaultPlanSelected).toBe(false)

  describe 'removePlan', ->
    describe 'valid params mock', ->
      beforeEach ->
        scope.selectedPlan = plan
        httpMock.whenDELETE("/coaches/plans/#{plan.id}").respond(plans: ['plan1', 'plan2'] )
        scope.removePlan()
        httpMock.flush()

      it 'should assign responded plans to scope.plans', ->
        expect(scope.plans).toEqual(["plan1", "plan2"])

      it 'should call $notification.success', ->
        expect(notification.success).toHaveBeenCalled();

    describe 'invalid params mock', ->
      beforeEach ->
        scope.selectedPlan = plan
        httpMock.whenDELETE("/coaches/plans/#{plan.id}").respond(403, message: 'error')
        scope.removePlan()
        httpMock.flush()

      it 'should call $notification.error', ->
        expect(notification.error).toHaveBeenCalled();


