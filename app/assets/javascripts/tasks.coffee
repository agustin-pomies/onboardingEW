$ ->
  stringify_date = (date) ->
    dd = date.getDate()
    mm = date.getMonth() + 1
    yyyy = date.getFullYear()
    if dd < 10
      dd = '0' + dd
    if mm < 10
      mm = '0' + mm
    string = yyyy + '-' + mm + '-' + dd

  current_date = ->
    stringify_date(new Date)

  invalid_date = ->
    stringify_date(new Date(null))

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
