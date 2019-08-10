module ActiveAdmin
  module Views

    class ActionItems < ActiveAdmin::Component

      def build(action_items)
        ul do |ul|
          ul.add_class "header-item tabs"
          action_items.each do |action_item|
            li do |li|
              li.add_class "action_item " + action_item.name.to_s
              instance_exec(&action_item.block)
            end
          end
        end
      end

    end

  end
end
