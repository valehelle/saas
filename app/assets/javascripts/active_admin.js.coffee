//= require jquery
//= require jquery_ujs
//= require active_admin/base
$ ->
 minmax = true;
 $('#filters_sidebar_section').click (e) ->
    minmax = false
    true
 $('#sidebar').click (e) ->
    position = $(this).position()
    width = $(this).width()
    if e.pageX < position.left && minmax
      if $(this).css('right') == '0px'
        $(this).css 'position', 'fixed'
        $(this).animate { right: '-=' + width }, 600, ->
          animationFilterDone = true
          return
      else
        $(this).animate { right: '+=' + width }, 600, ->
          $(this).css 'position', 'absolute'
          animationFilterDone = true
          return
    minmax = true;
    return
  animationDone = true
  $('#utility_nav').click (e) ->
    position = $(this).position()
    tabs = $('#tabs')
    width = Math.round(tabs[0].getBoundingClientRect().width)
    if e.pageX < position.left + 40
      if animationDone == true
        animationDone = false
        if tabs.css('left') == '0px'
          tabs.animate { left: '-=' + width }, 400, ->
            animationDone = true
            return
        else
          tabs.animate { left: '+=' + width }, 400, ->
            animationDone = true
            return
    return
  $('body').click (e) ->
    tabs = $('#tabs')
    width = Math.round(tabs[0].getBoundingClientRect().width)
    if tabs.css('left') == '0px'
      if e.pageX > width and e.pageY > 60
        if animationDone == true
          animationDone = false
          tabs.animate { left: '-=' + width }, 400, ->
            animationDone = true
            return
    return
  $('#tabs .has_nested').click (e) ->
    if $(this).hasClass('open') == true
      $(this).removeClass 'open'
    else
      $(this).addClass 'open'
    return
  return