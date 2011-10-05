class SettingsAction < Cramp::Action
  def start
    Settings.guest_list = params[:guest_list]
    finish
  end
end


