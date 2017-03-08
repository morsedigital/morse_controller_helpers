require "spec_helper"

class GenericController < ActionController::Base
  include MorseControllerHelpers
end

class Thing; end
class ThingStuff; end

RSpec.describe MorseControllerHelpers, type: :controller do
  let(:controller) { GenericController.new }

  describe 'klass' do
    it 'should constantize the klass_camel' do
      allow(controller).to receive(:klass_camel).and_return('ThingStuff')
      expect(controller.klass).to eq ThingStuff
    end
  end

  describe 'klass_camel' do
    before do
      allow(controller).to receive(:controller_name).and_return('things')
    end
    it 'should singularize the controller name' do
      expect(controller.klass_camel).to eq 'thing'
    end
  end

  describe 'klass_humanized' do
    before do
      allow(controller).to receive(:klass_camel).and_return('ThingStuff')
    end
    it 'should singularize the klass_camel' do
      expect(controller.klass_humanized).to eq 'Thingstuff'
    end
  end

  describe 'klass_id' do
    before do
      allow(controller).to receive(:klass_snake).and_return('thing_stuff')
    end
    it 'should add id to the klass_snake' do
      expect(controller.klass_id).to eq 'thing_stuff_id'
    end
  end

  describe 'klass_pluralized' do
    before do
      allow(controller).to receive(:klass_snake).and_return('thing_stuff')
    end
    it 'should singularize the klass_snake' do
      expect(controller.klass_pluralized).to eq 'thing_stuffs'
    end
  end

  describe 'klass_snake' do
    it 'should underscore the klass_camel' do
      allow(controller).to receive(:klass_camel).and_return('ThingStuff')
      expect(controller.klass_snake).to eq 'thing_stuff'
    end
  end

  describe 'params_resource_ids' do
    it 'should extract the params ending in _id' do
      allow(controller).to receive(:params).and_return({'whev' => 'hello', 'thing_id' => 12, 'other_thing_id' => 10})
      expected = ['thing_id', 'other_thing_id']
      expect(controller.params_resource_ids).to eq expected
    end
  end

  describe 'params_resources' do
    it 'should turn params_resource_ids into resources' do
      allow(controller).to receive(:params_resource_ids).and_return ['thing_id', 'other_thing_id']
      expected = ['thing', 'other_thing']
      expect(controller.params_resources).to eq expected
    end
  end
end
