u = up.util
$ = jQuery

beforeEach ->
  jasmine.addMatchers
    toHaveOwnProperty: (util, customEqualityTesters) ->
      compare: (object, expectedProperty) ->
        pass: object.hasOwnProperty(expectedProperty)
