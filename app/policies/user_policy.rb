class UserPolicy < ApplicationPolicy
  def show?
    user == record
  end

  class Scope < Scope
    def resolve
      # scope.where(id: user.id)
      scope.all
    end
  end
end
