require 'action_controller'
require 'active_support/all'
require 'morse_controller_helpers/version'
require 'morse_controller_helpers/crud_helpers'
require 'morse_controller_helpers/flash_helpers'

module MorseControllerHelpers
  extend ActiveSupport::Concern
  include MorseControllerHelpers::CrudHelpers
  include MorseControllerHelpers::FlashHelpers

  included do
    helper_method :params_resources,
                  :path_edit,
                  :path_index,
                  :path_new,
                  :path_show
    before_filter :dynamic_current_instance
  end

  def assign_current_instance_from_params(pri)
    klass_us = pri.gsub('_id', '')
    klass = klass_us.classify.constantize
    if klass.respond_to?(:friendly)
      instance_variable_set "@#{klass_us}", klass.friendly.find(params[pri])
    else
      instance_variable_set "@#{klass_us}", klass.find(params[pri])
    end
    @current_instance = set_current_instance(klass_us)
  end

  def dynamic_current_instance
    params_resource_ids.each do |pri|
      begin
        if try(:dynamic_current_instance_exceptions)
          next if dynamic_current_instance_exceptions.include? pri
        end
        assign_current_instance_from_params(pri)
      rescue ActiveRecord::RecordNotFound
        render_404
      end
    end
  end

  def klass(str = klass_camel)
    str.classify.constantize
  end

  def klass_camel
    controller_name.singularize
  end

  def klass_humanized
    klass_camel.humanize
  end

  def klass_id
    "#{klass_snake}_id"
  end

  def klass_pluralized
    klass_snake.pluralize
  end

  def klass_snake(str = klass_camel)
    str.underscore
  end

  def params_resource_ids
    params.keys.collect { |p| p if p.include?('_id') }.compact
  end

  def params_resources
    params_resource_ids.map { |p| p.gsub('_id', '') }
  end

  def params_resource
    params.require(resource_symbol).permit!
  end

  def path_edit(cp = current_instance)
    [:edit, path_prefix, cp].compact
  end

  def path_index
    [path_prefix, resource_symbols].compact
  end

  def path_new
    [:new, path_prefix, resource_symbol].compact
  end

  def path_prefix
    nil
  end

  def path_prefix_symbol
    return nil unless path_prefix
    path_prefix.to_sym
  end

  def path_show(instance = current_instance)
    [path_prefix, instance].compact
  end

  def resource_symbol
    klass_snake.to_sym
  end

  def resource_symbols
    klass_pluralized
  end.to_sym

  def render_404
    flash_404_error
    respond_to do |format|
      format.html do
        render file: "#{Rails.root}/public/404",
               layout: false,
               status: :not_found
      end
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def set_current_instance(k)
    instance_variable_get("@#{k}") unless action_name == 'index'
  end
end
