# frozen_string_literal: true

module Api
  module Queries
    class Events < BaseQuery
      type [Types::EventType], null: false

      argument :pagination, InputObjects::Pagination,  required: false
      argument :filter,     InputObjects::EventFilter, required: false

      description "Get list of all visible pivorak's events info"

      def resolve(pagination: {}, filter: {})
        events = Event.visible.published

        events = events.where(status:   filter[:status])   if filter[:status]
        events = events.where(venue_id: filter[:venueIds]) if filter[:venueIds]

        events.offset(pagination[:offset]).limit(pagination[:limit]).order(started_at: :desc)
      end
    end
  end
end
