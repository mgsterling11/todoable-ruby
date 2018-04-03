require 'todoable/resources/resource_base'

module Todoable
  module Resources
    class TodoList < Todoable::Resources::ResourceBase

      def initialize(config)
        super(config)
        @endpoint = "lists"
      end

      def find_item(list_id, item_id, body={})
        request = {}
        submit(request)
      end

      def create_item(list_id, body={})
        headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }

        request = {
            method: :post,
            url: item_url(list_id),
            body: body,
            headers: headers
        }
        submit(request)
      end

      def finish_item(list_id, item_id)
        headers = {
            'Accept': 'application/json'
        }

        request = {
            method: :put,
            url: "#{item_url(list_id)}/#{item_id}/finish",
            headers: headers
        }
        submit(request)
      end

      def destroy_item(list_id, item_id)
        headers = {
            'Accept': 'application/json'
        }

        request = {
            method: :delete,
            url: "#{item_url(list_id)}/#{item_id}",
            headers: headers
        }
        submit(request)
      end

      private

      def item_url(list_id)
        "#{resource_url(list_id)}/items"
      end

    end
  end
end