class RegistrationsController < Devise::RegistrationsController
  before_filter :admin_protect
  skip_before_filter :require_no_authentication
end