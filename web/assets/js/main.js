$(function(){
    process_platform_specific_content();
    setup_show_archived_versions_button();
    setup_accordion_scroller();
    $(function () { $('[data-toggle="tooltip"]').tooltip() })

    setTimeout(function() {
        $('.need-help').removeClass('invisible').animate({opacity: 1});
    }, 5000);
    $(window).on('load', function() {
        $('.preload').removeClass('preload');
    });

    setup_same_height();
});

function setup_same_height() {
    $.fn.sameHeight = function() {
        var max = {};
        $(this).each(function(){
            var h = $(this).outerHeight();
            var o = $(this).offset().top;
            if (max[o] === undefined) max[o] = 0
            if ( h > max[o] ) { max[o] = h }
        });
        $(this).each(function(){
            $(this).css('min-height', max[$(this).offset().top] + 'px')
        });
    }

    $('#alt-star .card-body, #files-rakudo-third-party .card-body').sameHeight();
}

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

function setup_show_archived_versions_button() {
    $('.show-archived-versions').on('click', function(){
        $(this).parents('table,.article-list').find('.archived')
            .css({opacity: 0})
            .removeClass('archived').animate({opacity: 1}, 1000);
        $(this).remove();
    });
}

function process_platform_specific_content() {
    var fam    = query_param('platform', platform.os.family).toLowerCase(),
        wanted = 'generic';

    if (fam.indexOf('windows') >= 0 && fam.indexOf('windows phone') == -1) {
        wanted = 'windows';
    }
    else if (fam.match(/ubuntu|debian|fedora|red hat|suse|ios|android/)) {
        wanted = fam.replace(/ /g, '_');
    }

    $('.platform-options').each(function(){
        var show = $(this).find('[data-platform~=' + wanted + ']');
        if (! show.length)
            show = $(this).find('[data-platform~=generic]');
        $('[data-platform]').css({position: 'absolute', left: '-9999px'});
        show.css({position: 'static', left: 'auto'});
    })

    if ($('.downloads-panel [data-platform-mark~=' + wanted + ']').length) {
        $('.downloads-panel [data-platform-mark]').each(function(){
            if ($(this).attr('data-platform-mark').indexOf(wanted) >= 0) {
                $(this).removeClass('btn-dark').addClass('btn-primary')
                .next('a').removeClass('btn-dark').addClass('btn-warning');
            }
        });
    }
    else {
        $('.downloads-panel .download')
            .removeClass('btn-dark').addClass('btn-primary')
        .next('a')
            .removeClass('btn-dark').addClass('btn-warning')
    }
}


function query_param(wanted, or) {
    var params = decodeURIComponent(
        window.location.search.substring(1)
    ).split('&'), name, i;

    for (i = 0; i < params.length; i++) {
        param = params[i].split('=');
        if (param[0] === wanted)
            return param[1] === undefined ? true : param[1]
    }
    return or;
}
