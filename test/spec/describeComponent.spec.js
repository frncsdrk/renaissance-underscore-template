define(function(require) {
    'use strict';

    var defineComponent = require('renaissance/renaissance').defineComponent;
    var Example = require('mock/example');

    describeComponent('mock/example', function() {
        describe('this.Component', function() {
            it('should be an Example component', function() {
                expect(this.Component).toEqual(Example);
            });
        });
    });
});
