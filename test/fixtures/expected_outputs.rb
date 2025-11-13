# test/fixtures/expected_outputs.rb
# frozen_string_literal: true

module ExpectedOutputs
  FORM_WITH_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" value="rob" type="text">
      <label for="job">Job</label>
      <textarea name="job" cols="20" rows="40">hexlet</textarea>
    </form>
  HTML

  FORM_WITH_ADDITIONAL_ATTRIBUTES = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" class="user-input" value="rob" type="text">
      <label for="job">Job</label>
      <input name="job" value="hexlet" type="text">
    </form>
  HTML

  FORM_WITH_CHECKBOX_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="gender">Gender</label>
      <input name="gender" type="checkbox" checked>
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
      <input name="name" value="rob" type="text">
    </form>
  HTML

  # ИЗМЕНЕНО: <button> → <input type="submit">
  FORM_WITH_LABELS_AND_SUBMIT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" value="rob" type="text">
      <label for="job">Job</label>
      <input name="job" value="hexlet" type="text">
      <input type="submit" value="Save">
    </form>
  HTML

  # ИЗМЕНЕНО: <button> → <input type="submit">
  FORM_WITH_CUSTOM_SUBMIT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="name">Name</label>
      <input name="name" value="rob" type="text">
      <label for="job">Job</label>
      <input name="job" value="hexlet" type="text">
      <input type="submit" value="Update">
    </form>
  HTML

  FORM_WITH_CHECKBOX_FALSE = <<~HTML.strip
    <form action="/users" method="post">
      <label for="accepted">Accepted</label>
      <input name="accepted" type="checkbox">
    </form>
  HTML

  FORM_WITH_PASSWORD_INPUT = <<~HTML.strip
    <form action="/users" method="post">
      <label for="password">Password</label>
      <input name="password" type="password" value="secret123">
    </form>
  HTML

  FORM_WITH_PASSWORD_CUSTOM = <<~HTML.strip
    <form action="/users" method="post">
      <label for="password">Password</label>
      <input name="password" type="password" class="form-control" placeholder="Enter password" value="secret123">
    </form>
  HTML
end
