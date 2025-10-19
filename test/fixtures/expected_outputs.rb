# test/fixtures/expected_outputs.rb
module ExpectedOutputs
  FORM_WITH_INPUT = '<form action="/users" method="post"><input name="name" type="text" value="rob"><textarea name="job" cols="20" rows="40">hexlet</textarea></form>'
  
  FORM_WITH_ADDITIONAL_ATTRIBUTES = '<form action="/users" method="post"><input name="name" type="text" value="rob" class="user-input"><input name="job" type="text" value="hexlet"></form>'
  
  FORM_WITH_CHECKBOX_INPUT = '<form action="/users" method="post"><input name="gender" type="checkbox" value="m" checked></form>'
  
  FORM_WITH_SELECT_INPUT = '<form action="/users" method="post"><select name="gender"><option value="m" selected>m</option><option value="f">f</option></select></form>'
  
  FORM_WITH_TEXTAREA_DEFAULTS = '<form action="/users" method="post"><textarea name="job" cols="20" rows="40">hexlet</textarea></form>'
  
  FORM_WITH_CUSTOM_TEXTAREA = '<form action="/users" method="post"><textarea name="job" cols="50" rows="50">hexlet</textarea></form>'
  
  FORM_WITH_PASSWORD = '<form action="/users" method="post"><input name="password" type="password"></form>'
  
  FORM_WITH_DEFAULT_INPUT = '<form action="/users" method="post"><input name="name" type="text" value="rob"></form>'
end
