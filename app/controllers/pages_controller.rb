class PagesController < ApplicationController
  def home
    @users = User.all
    @skills = Skill.all
    @training_plans = TrainingPlan.all
    @resources = Resource.all
  end
end
