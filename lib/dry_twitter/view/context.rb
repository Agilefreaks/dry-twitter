module DryTwitter
  module View
    class Context
      attr_reader :attrs

      def initialize(attrs = {})
        @attrs = attrs
      end

      def csrf_token
        self[:csrf_token]
      end

      def csrf_metatag
        self[:csrf_metatag]
      end

      def csrf_tag
        self[:csrf_tag]
      end

      def flash
        self[:flash]
      end

      def flash?
        %i[notice alert].any? { |type| flash[type] }
      end

      def with(new_attrs)
        self.class.new(attrs.merge(new_attrs))
      end

      def user_name
        self[:session][:user_name]
      end

      def sign_in_class
        "nav-item #{'collapse' if user_name}"
      end

      def sign_out_class
        "nav-item #{'collapse' if user_name.nil?}"
      end

      private

      def [](name)
        attrs.fetch(name)
      end
    end
  end
end
