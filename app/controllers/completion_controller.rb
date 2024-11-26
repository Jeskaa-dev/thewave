class CompletionController < ApplicationController
  before_action :set_completion, only: %i[edit update]

  def edit
  end

  def update
    @completion.update(done: true)
    redirect_to root_path
  end

  private

  def set_completion
    @completion = Completion.find(params[:id])
  end
end
