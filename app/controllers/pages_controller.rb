class PagesController < ApplicationController

  # def index
  # end

  def home
    @user = current_user
    @users = User.all
    @skills = Skill.all
    @training_plans = TrainingPlan.all
    @resources = Resource.all
  end

end
