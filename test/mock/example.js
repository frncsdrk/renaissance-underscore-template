define(function(require) {
    'use strict';

    var defineComponent = require('renaissance/renaissance').defineComponent;

    function Example() {
        var meta = {
            param: defaultParam
        }

        this.after('init', function(component) {
            //
        });
    }

    return defineComponent(Example);
});
