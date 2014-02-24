module ApplicationHelper
  def edit_and_destroy_buttons_for item
    if current_user and current_user.admin?
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-info")
      del = link_to('Delete', item, method: :delete,
                    data: {confirm: 'Are you sure?' }, class:"btn btn-danger")
      raw("#{edit} #{del}")
    end
  end

  def round num
  	number_with_precision(num, precision: 2)
  end
end