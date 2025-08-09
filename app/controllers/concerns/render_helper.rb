# app/controllers/concerns/render_helper.rb
module RenderHelper
  extend ActiveSupport::Concern

  private

  def res(resources, options = {})
    options.merge! serializer_opt_for(resources, options) if options[:as].present?
    render options.merge json: resources, root: :data
  end

  def render_error(errors, message: nil, status: :unprocessable_entity)
    render json: { errors:, message: }, status: status
  end

  def serializer_opt_for(resources, options)
    return {} if resources.blank?

    opt = options[:as]
    {}.tap do |hash|
      case resources
      when ActiveRecord::Relation
        hash[:each_serializer] = serializer_class resources.model, opt
      when Array
        hash[:each_serializer] = serializer_class resources.first.class, opt
      else
        hash[:serializer] = serializer_class resources.class, opt
      end
    end
  end

  def serializer_class(resource_class, opt)
    "#{api_version}::#{resource_class.name}::#{opt.to_s.classify}Serializer".constantize
  rescue NameError => e
    Rails.logger.error(e)
  end

  def api_version
    "V1"
  end
end
