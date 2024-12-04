class PagePolicy < ApplicationPolicy

  def index?
    true
  end

  def home?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
