$(function(){
    setup_accordion_scroller();
    if ( ! navigator.userAgent.match(/iPad/i) ) {
        setup_thumbnailer();
    }
});

function setup_accordion_scroller() {
    $('.accordion').on('shown.bs.collapse', function() {
        var el = $(this).find('.collapse.show');
        var offset = el.offset();
        var scroll = $(window).scrollTop();
        if (offset.top < scroll || offset.top + el.height()
            > scroll + $(window).height()) {
            $('html, body').animate({ scrollTop: offset.top });
        }
    });
}

function setup_thumbnailer () {
    var imgs = $('img');
    var loaded_imgs = 0;
    var total_images = imgs.length;
    imgs.each(function() {
        $("<img>").attr("src", $(this).attr('src')).on('load',function() {
            if (++loaded_imgs < total_images) return;
            $('.thumbs-container').each(function(){
                var c  = $(this);
                var ul = c.find('.thumbs-list');
                var h  = ul.find('li:first-child img');
                var thumb_num = ul.find('img').length;
                var half_offset = 0;
                ul.find('img').each(function(){
                    half_offset += $(this).width();
                });

                var thumb_offset = (
                    $('body').width() - half_offset - thumb_num*10
                )/thumb_num;
                if (thumb_offset > 10) thumb_offset = 10;

                half_offset = (
                    half_offset + thumb_offset*thumb_num - h.width()/2 - thumb_offset
                )/2;

                c.on('mouseover', function() {
                    var offset = 0;
                    ul.css({left: 0, top: 0, visibility: 'visible'});
                    ul.find('img').each(function(){
                        var el = $(this);
                        el.css({
                            position: 'absolute',
                            left: c.width()/2 + 'px',
                            top: 0
                        });
                        el.animate({
                            left: (half_offset-offset) + 'px',
                            top: (-h.height()+10) + 'px'
                        }, {
                            duration: 900,
                            queue: false,
                            specialEasing: {
                                top: "easeOutElastic",
                                left: "easeOutElastic"
                            }
                        })
                        offset += el.width() + thumb_offset;
                    })
                });
                c.on('mouseout', function(){
                    ul.css({
                        visibility: 'hidden'
                    })
                })
            });
        });
    });

}
