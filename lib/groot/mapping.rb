module Groot 
  class Mapping
    attr_accessor :resource, :class_name, :path_names
    def initialize(resource)
      @resource = resource
      @path_names = Hash.new { |h,k| h[k] = k.to_s }
    end

    def singular
      resource.to_s.singularize
    end
    alias :name :singular

    def class_name
      @class_name ||= singular.classify
    end

    def clazz
      @clazz ||= class_name.constantize
    end
  end
end