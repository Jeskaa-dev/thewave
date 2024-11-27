class CompletionController < ApplicationController
  def done
    @completion = Completion.find(params[:id])
    authorize @completion
    @completion.update(done: true)
    redirect_to training_plan_path(@completion.training_plan)
  end
end
