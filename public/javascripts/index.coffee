old = ->
  $("#sigup").click ->
    $("#signup-form").modal()
  $("#login-o").click ->
    $("#login-form").modal()
    no
  $("#signup-form > form").submit ->
    $.post '/users', {
      username: $("#username").val()
      password: $("#password").val()
      email: $("#email").val()
      firstName: $("#firstName").val()
      lastName: $("#lastName").val()
    }, (data) ->
      $("#signup-form").modal 'hide'
      alert '对不起，注册用户出错，请稍后再试！' if 'success' != data.result
    no

class Content extends Spine.Model
  @configure 'Content', 'nav_widget'

class App extends Spine.Controller
#  events:

  elements:
    '#admin-o': 'adminBtn'
  construtor: ->
    super



$ ->
  old()

