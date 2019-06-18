# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on "ajax:success", "form#comments-form", (ev,data)->
#  $("#comments-box").append("<li> #{data.body} - #{} </li>")

$ ->
  $(document).on "change", "input[type~=checkbox]", ->
  url = $(this).data("url")
  $.ajax(url, dataType: "script", method: "POST")

  # Update completed field for task when it's clicked
  $(".check").change ->
    $.ajax
      url: task_path(@task)
      type: "PUT"
      dataType: "script"
      data:
        task:
          completed: $("input[name='task[completed]']").is(':checked')
    alert "Hola Pomi, funciono!!"
    #$().toggle()

  #
  # if $(".check")[0].checked == false
  #  alert "Hola Pomi, funciono!!"
