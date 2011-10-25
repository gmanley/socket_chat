// Copyright (c) Whenever, Corey Schram
//
// jQuery wiggle plugin!
// wiggles!

(function ($) {

    var defaults = {
        waggle : 5,
        duration : 2,
        interval : 200
    };

    function rand(waggle) {
        return Math.random() % (waggle - (waggle / 2) + 1) + (waggle / 2);
    }

    $.fn.wiggle = function (options, callback) {
        options = $.extend({}, defaults, options);

        var duration = options.duration,
            elem = this,
            moveLeft = false,
            left = elem.css('left'),
            pos = elem.css('position');
        elem.css('position', 'relative');

        function doWiggle() {
            var move = rand(options.waggle);
            elem.animate({
                left : moveLeft ? move : -move
            }, options.interval);
            moveLeft = !moveLeft;

            if (options.wiggleCallback) {
                options.wiggleCallback(elem);
            }

            duration -= options.interval / 1000;
            if (duration <= 0) {
                elem.css('left', left);
                elem.css('position', pos);

                // clearTimeout(timeout);

                callback && callback(elem);
            } else {
                setTimeout(doWiggle, options.interval);
            }
        }
        setTimeout(doWiggle, options.interval);
    };

})(jQuery);