module Cp
  class PostsController < Cp::ApplicationController
    def scoped_resource
      if params[:date].present?
        start_of_day = DateTime.parse(params[:date])
        end_of_day   = start_of_day.end_of_day

        resource_class.where(publish_date: start_of_day..end_of_day)
      else
        resource_class.order(publish_date: :desc)
      end
    end

    def valid_action?(name, resource = resource_class)
      %w[index].include?(name.to_s)
    end
  end
end
