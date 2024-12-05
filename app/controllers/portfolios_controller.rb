class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: [:show, :edit, :update, :update_step]

  def show
    @user = current_user

  end

  def edit

  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to @portfolio, notice: "Portfolio mis à jour avec succès."
    else
      render :edit, alert: "Erreur lors de la mise à jour du portfolio."
    end
  end

  def update_step
    if @portfolio.update(portfolio_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("step-#{params[:step]}", partial: "portfolios/step_form", locals: { portfolio: @portfolio, step: params[:step].to_i })
        end
        format.html { redirect_to portfolio_path, notice: "Étape mise à jour avec succès." }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("step-#{params[:step]}", partial: "portfolios/step_form", locals: { portfolio: @portfolio, step: params[:step].to_i })
        end
        format.html { render :show, alert: "Erreur lors de la mise à jour de l'étape." }
      end
    end
  end

  private

    def set_portfolio
      @portfolio = current_user.portfolio
    end

    def portfolio_params
      params.require(:portfolio).permit(:step_1_github_url, :step_1_site_url, :step_2_github_url, :step_2_site_url, :step_3_github_url, :step_3_site_url, :step_4_github_url, :step_4_site_url, :step_5_github_url, :step_5_site_url)
    end

end
