$("input[type=checkbox]").live 'change', ->
  $p      = $(this).closest('article')
  $custom = $p.find('.custom')

  checked = $(this).attr('checked')

  if checked
    $p.addClass 'checked'
    $custom.show()
    $custom.find('input, select').removeAttr 'disabled'
    $($custom.find('input')[0]).focus()

    # Implies?
    list = ("" + $(this).attr('data-implies')).split(' ')
    for i of list
      $checkbox = $("input:checkbox[value=#{list[i]}]")
      $checkbox.attr 'checked', 1
      $checkbox.trigger 'change'

  else
    $p.removeClass 'checked'
    $custom.hide()
    $custom.find('input, select').attr('disabled', 1)


$("form").live 'submit', (e) ->
  caught = false
  $(".custom input:not(:disabled)").each ->
    if $(this).val() == "" and !caught
      caught = true
      $(this).focus()
      alert "Please fill in all the fields."

      e.stopPropagation()
      e.preventDefault()

$(".custom input").live 'focus', ->
  $(this).closest('.custom').addClass 'focus'

$(".custom input").live 'blur', ->
  $(this).closest('.custom').removeClass 'focus'

$("input.command").live 'focus click', ->
  @selectionStart = 0
  @selectionEnd = 99999

$ ->
  $(":checkbox").removeAttr 'checked'
