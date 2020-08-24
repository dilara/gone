# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :set_member, only: :show
  
  def show; end
  
  private
  
  def set_member
    member = User.member.find(params[:id])
    @member = UserDecorator.new(member)
  end
end
