class NullObject
  def respond_to_missing?(_method_name, _include_private = false)
    true
  end

  def method_missing(_method_name, *_arguments, &_block)
    nil
  end
end
