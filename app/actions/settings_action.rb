class SettingsAction < Cramp::Action
  def start
    if params.has_key?(:guest_list)
      Settings.guest_list = params[:guest_list]
    end
    render Settings.settings.to_json
    finish
  end

  def respond_with
    content_type = 'application/json'
    [200, {'Content-Type' => content_type}]
  end
  
end


