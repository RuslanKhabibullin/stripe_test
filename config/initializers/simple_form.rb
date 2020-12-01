# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers :default, class: :input, error_class: :error do |b|
    b.use :html5
    b.use :placeholder

    b.optional :readonly
    b.optional :min_max
    b.optional :maxlength

    b.use :label_input
    b.use :hint, wrap_with: { tag: :p, class: "help-text input-hint" }
    b.use :error, wrap_with: { tag: :small, class: :error }
  end

  # CSS class for buttons
  config.button_class = "button"

  # Set this to div to make the checkbox and radio properly work
  # otherwise simple_form adds a label tag instead of a div around
  # the nested label
  config.item_wrapper_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = "alert alert--alert"

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default
end
