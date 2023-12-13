# From https://github.com/CanCanCommunity/cancancan/issues/106

# Variant 1

# if defined?(CanCan)
#   class Object
#     def metaclass
#       class << self; self; end
#     end
#   end

#   module CanCan
#     module ModelAdapters
#       class ActiveRecordAdapter < AbstractAdapter
#         @@friendly_support = {}

#         def self.find(model_class, id)
#           klass =
#           model_class.metaclass.ancestors.include?(ActiveRecord::Associations::CollectionProxy) ?
#             model_class.klass : model_class
#           @@friendly_support[klass]||=klass.metaclass.ancestors.include?(FriendlyId)
#           @@friendly_support[klass] == true ? model_class.friendly.find(id) : model_class.find(id)
#         end
#       end
#     end
#   end
# end

# Variant 2

require 'cancan'

module CanCan
  module ModelAdapters
    class AbstractAdapter
      def self.find(model_class, id)
        model_class.respond_to?(:friendly) ?
          model_class.friendly.find(id) : model_class.find(id)
      end
    end
  end
end