# This module provides pagination functionality for controllers.
module Paginatable
  extend ActiveSupport::Concern

  included do
    before_action :check_page_range, if: :paginatable_model, only: %i[index show]
  end

  protected

  def check_page_range
    total_pages = total_pages_for(paginatable_model)
    return unless params[:page].to_i > total_pages

    params[:page] = total_pages
  end

  def total_pages_for(model, per_page = 10)
    total_count = model.count
    (total_count.to_f / per_page).ceil
  end

  def paginatable_model
    nil
  end
end
