$("input[type=checkbox]").live 'change', ->
  $p      = $(this).closest('article')
  $custom = $p.find('.custom')

  checked = $(this).attr('checked')

  if checked
    $custom.show()
    $custom.find('input').removeAttr 'disabled'
  else
    $custom.hide()
    $custom.find('input').attr('disabled', 1)


$("form").live 'submit', (e) ->
  caught = false
  $(".custom input:not(:disabled)").each ->
    if $(this).val() == "" and !caught
      caught = true
      $(this).focus()
      alert "Please fill in all the fields."

      e.stopPropagation()
      e.preventDefault()

$("input.command").live 'focus click', ->
  @selectionStart = 0
  @selectionEnd = 99999

$("a[role=show-contents]").live 'click', ->
  $(".contents").show()
  $(this).hide()

  false

$ ->
  check = (value) ->
    $el = $("input[type=checkbox][value=#{value}]")
    $el.attr 'checked', true
    $el.trigger 'change'

  check 'openssh'
  check 'my-user'
