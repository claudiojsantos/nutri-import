class MockController
  include AbstractController::Callbacks
  include Paginatable
  attr_accessor :params

  def initialize
    @params = {}
  end

  def self.before_action(*args); end

  def paginatable_model
    MockModel
  end
end

class MockModel
  include Mongoid::Document

  def self.count
    100
  end
end

require 'rails_helper'

RSpec.describe Paginatable, type: :concern do
  subject(:controller) { MockController.new }

  describe '#check_page_range' do
    context 'when the page param exceeds the total pages' do
      it 'sets the page param to the last page' do
        controller.params[:page] = 11
        controller.send(:check_page_range)
        expect(controller.params[:page]).to eq(10)
      end
    end

    context 'when the page params is within the range' do
      it 'does not modify the page param' do
        controller.params[:page] = 5
        controller.send(:check_page_range)
        expect(controller.params[:page]).to eq(5)
      end
    end
  end

  describe '#total_pages_for' do
    it 'calculates the total pages for the given model' do
      total_pages = controller.send(:total_pages_for, MockModel)
      expect(total_pages).to eq(10)
    end
  end
end
