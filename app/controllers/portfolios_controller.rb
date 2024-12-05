class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: [:show, :edit, :update]

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

  private

    def set_portfolio
      @portfolio = current_user.portfolio
    end

    def portfolio_params
      params.require(:portfolio).permit(:step_1_github_url, :step_1_site_url, :step_2_github_url, :step_2_site_url, :step_3_github_url, :step_3_site_url, :step_4_github_url, :step_4_site_url, :step_5_github_url, :step_5_site_url)
    end

end
