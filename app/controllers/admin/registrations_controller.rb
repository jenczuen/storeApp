class Admin::RegistrationsController < Devise::RegistrationsController
	before_filter :authenticate_admin_admin!
end