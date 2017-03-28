ActiveAdmin.register Post do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  permit_params :id, :user_id, :title, :body, :created_at, :updated_at, :image

  index do
    column :id
    column :user_id
    column :title
    column :body
    column :created_at
    column :updated_at
    column :image
    actions
  end
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
end
