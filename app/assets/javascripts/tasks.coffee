# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> # when DOM Ready
  stringfy_date = (date) ->
    dd = date.getDate()
    mm = date.getMonth() + 1
    yyyy = date.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    string = yyyy + '-' + mm + '-' + dd

  # Function to return the current date
  current_date = ->
    stringfy_date(new Date)

  # Function to return invalid date
  invalid_date = ->
    stringfy_date(new Date(null))

  # Decides which date is passed to the model depending of the value of a boolean
  choose_date = (bool) ->
    if bool
      date = current_date()
    else
      date = invalid_date()

  # Update completed field for task when it's clicked
  $('.check').on "change", ->
    id = this.value
    completed = this.checked
    url = "/tasks/#{id}.json"
    $.ajax
      type: "PATCH"
      url: url
      dataType: "json"
      data:
        task:
          completed: completed
          completed_date: choose_date(completed)
