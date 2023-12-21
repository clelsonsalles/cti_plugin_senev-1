class WelcomeController < ApplicationController
  self.main_menu = false

  skip_before_action :check_if_login_required, only: [:robots]

  helper :custom_fields

  def index
    @news = News.latest User.current
    @projects = User.current.projects.to_a
  end

  def robots
    @projects = Project.visible(User.anonymous) unless Setting.login_required?
    render :layout => false, :content_type => 'text/plain'
  end

end
