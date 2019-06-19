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

  wake_modal = ->
    $('.modal-background')[0].style.display = 'block'

  sleep_modal = ->
    $('.modal-background')[0].style.display = 'none'

  change_position = (obj, bool) ->
    if bool
      previous_list = '.incomplete'
      new_list = '.complete'
    else
      previous_list = '.complete'
      new_list = '.incomplete'

    wrapper = obj.parentElement
    list_item = obj.parentElement.parentElement

    list_item.remove()
    $(new_list)[0].appendChild(list_item)

    if bool
      text = document.createTextNode("(Completed today!)")
      wrapper.appendChild(text)
    else
      wrapper.childNodes[4].remove()

  # Disappear modal when it's clicked
  $('.modal-background').on 'click', ->
    sleep_modal()

  # Update completed field for task when it's clicked
  $('.check').on "change", ->
    id = this.value
    completed = this.checked
    change_position(this, completed)
    if completed
      wake_modal()
    url = "/tasks/#{id}.json"
    $.ajax
      type: "PATCH"
      url: url
      dataType: "json"
      data:
        task:
          completed: completed
          completed_date: choose_date(completed)
