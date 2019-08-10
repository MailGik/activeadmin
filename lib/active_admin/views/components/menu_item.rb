module ActiveAdmin
  module Views

    # Arbre component used to render ActiveAdmin::MenuItem
    class MenuItem < Component
      builder_method :menu_item
      attr_reader :label
      attr_reader :url
      attr_reader :priority
      attr_reader :fa_icon
      attr_reader :counter

      def build(item, options = {})
        super(options.merge(id: item.id))
        @label = helpers.render_in_context self, item.label
        @url = helpers.render_in_context self, item.url
        @priority = item.priority
        @submenu = nil

        add_class "current" if item.current? assigns[:current_tab]

        if item.fa_icon
          @label = ('<i class="menu-icon ' + item.fa_icon + '"></i>' + '<span>' + @label + '</span>').html_safe
        end

        if item.counter
          if item.items.any?
            @label = @label + ('<span class="menu-item-notification">' + item.counter.to_s + '</span>').html_safe
          else
            @label = (@label + '<span class="menu-item-notification">' + item.counter.to_s + '</span>').html_safe
          end
        end

        if url
          text_node link_to label, url, item.html_options
        else
          span label, item.html_options
        end

        if item.items.any?
          add_class "has_nested"
          a href: "#" do |a|
            a.add_class "panelMenuCollapse"
            i do |i|
              i.add_class "fa fa-angle-down"
              ''
            end
          end
          @submenu = menu(item)
        end
      end

      def tag_name
        'li'
      end

      # Sorts by priority first, then alphabetically by label if needed.
      def <=>(other)
        result = priority <=> other.priority
        result == 0 ? label <=> other.label : result
      end

      def visible?
        url.nil? || real_url? || @submenu && @submenu.children.any?
      end

      def to_s
        visible? ? super : ''
      end

      private

      # URL is not nil, empty, or '#'
      def real_url?
        url && url.present? && url != '#'
      end
    end
  end
end
