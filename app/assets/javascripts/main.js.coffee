class Field
  constructor: (object, type) ->
    @object = object
    @type = type
  buttonChange: (oldClass, newClass) ->
    button = $(".btn-#{oldClass}")
    button.removeClass "btn-#{oldClass}"
    button.addClass "btn-#{newClass}"
  group: ->
    $(@object).parent().parent()
  span: ->
    $(@object).parent().children "span"
  addError: (message) ->
    @span().text(message)
    @group().addClass "error"
    @group().addClass "error-#{@type}"
    @buttonChange "primary", "danger"
  removeError: ->
    @group().removeClass "error-#{@type}"
    for item in ["blank", "confirm", "length"]
      if @group().hasClass "error-#{item}"
        return
    @span().text ""
    @group().removeClass "error"
    @buttonChange "danger", "primary"
  value: ->
    $(@object).val()

$().ready ->
  $.expander.defaults.slicePoint = 120
  $(".test-blank").blur (e) ->
    testBlank e.target
  $(".test-length").blur (e) ->
    testLength e.target, 8, 50
  $(".test-confirm").blur (e) ->
    testConfirm e.target
  $(".show-switch").click (e) ->
    passwordSwitch e.target
  $(".expandable").expander();
  $(".dropdown-toggle").dropdown()
  console.debug "Page loaded"

isBlank = (string) ->
  true if not string
  for char in string
    if (char != " ")
      return false
  true

testBlank = (object) ->
  field = new Field object, "blank"
  if isBlank field.value()
    field.addError "Field can't be blank"
  else
    field.removeError()

testLength = (object, min, max) ->
  field = new Field object, "length"
  if $(object).attr("type") == "password"
    if field.value().length < min or field.value().length > max
      field.addError "Password must be between 8 and 50 characters long"
    else
      field.removeError()
  else
    if field.value().length > max
      field.addError "Value must be less than 50 characters long"
    else
      field.removeError()

testConfirm = (object) ->
  field = new Field object, "confirm"
  password = $("#user_password").val()
  if field.value() != password
    field.addError "Confirmation doesn't match password"
  else
    field.removeError()

passwordSwitch = (object) ->
  for field in $(".show-hide")
    if $(field).attr("type") == "password"
      $(field).attr "type", "text"
      $(object).attr "src", "/assets/icons/hide.png"
    else
      $(field).attr "type", "password"
      $(object).attr "src", "/assets/icons/show.png"
