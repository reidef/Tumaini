module ApplicationHelper
  def bootstrap_flash(type)
    case type
      when :alert
        "error"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end
end
