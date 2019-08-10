module ActiveAdmin
  module Views
    class Header < Component

      def build(namespace, action_items)
        super(id: "header")

        @namespace = namespace
        @action_items = action_items
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        site_title @namespace
        build_action_items
        utility_navigation @utility_menu, id: "utility_nav", class: 'header-item tabs'
      end

      private

      def build_action_items
        insert_tag(view_factory.action_items, @action_items)
      end
    end
  end
end
