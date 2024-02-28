module ApplicationHelper

  def bootstrap_class_for_flash(type)
    case type
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    when 'error' then 'alert-denger'
    when 'alert' then 'alert-warning'
    else
      'alert-info'
    end
  end
end
