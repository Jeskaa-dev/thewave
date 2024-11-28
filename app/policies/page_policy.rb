class PagePolicy < ApplicationPolicy
  def home?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
