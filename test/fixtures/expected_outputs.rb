# test/fixtures/expected_outputs.rb
# frozen_string_literal: true

module ExpectedOutputs
  FORM_WITH_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" type="text" value="rob">
      <label for="job">Job</label>
      <textarea name="job" cols="20" rows="40">hexlet</textarea>
    </form>
  HTML

  FORM_WITH_ADDITIONAL_ATTRIBUTES = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" type="text" value="rob" class="user-input">
      <label for="job">Job</label>
      <input name="job" type="text" value="hexlet">
    </form>
  HTML

  FORM_WITH_CHECKBOX_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="gender">Gender</label>
      <input name="gender" type="checkbox" value="m" checked>
    </form>
  HTML

  FORM_WITH_SELECT_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="gender">Gender</label>
      <select name="gender">
        <option value="m" selected>m</option>
        <option value="f">f</option>
      </select>
    </form>
  HTML

  FORM_WITH_TEXTAREA_DEFAULTS = <<~HTML.strip
    <form action="/users" method="post">
      <label for="job">Job</label>
      <textarea name="job" cols="20" rows="40">hexlet</textarea>
    </form>
  HTML

  FORM_WITH_CUSTOM_TEXTAREA = <<~HTML.strip
    <form action="/users" method="post">
      <label for="job">Job</label>
      <textarea name="job" cols="50" rows="50">hexlet</textarea>
    </form>
  HTML

  FORM_WITH_PASSWORD = <<~HTML.strip
    <form action="/users" method="post">
      <label for="password">Password</label>
      <input name="password" type="password">
    </form>
  HTML

  FORM_WITH_DEFAULT_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" type="text" value="rob">
    </form>
  HTML

  FORM_WITH_LABELS_AND_SUBMIT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" type="text" value="rob">
      <label for="job">Job</label>
      <input name="job" type="text" value="hexlet">
      <input type="submit" value="Save">
    </form>
  HTML

  FORM_WITH_CUSTOM_SUBMIT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" type="text" value="rob">
      <label for="job">Job</label>
      <input name="job" type="text" value="hexlet">
      <input type="submit" value="Update">
    </form>
  HTML
end
