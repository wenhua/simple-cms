hideLabel = ->
  $('label').hide()
switchAdmin = ->
  $('#admin-o').click ->
    $('#admin-o-e').show()
    $(@).hide()
  $('#admin-o-e').hide().click ->
    $('#admin-o').show()
    $(@).hide()

$ ->
#  hideLabel()
  switchAdmin()