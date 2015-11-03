=begin
  Copyright (C) 2005 Jeff Rose

  This library is free software; you can redistribute it and/or modify it
  under the same terms as the ruby language itself, see the file COPYING for
  details.
=end
module Icalendar
  # A Todo calendar component is a grouping of component
  # properties and possibly Alarm calendar components that represent
  # an action-item or assignment. For example, it can be used to
  # represent an item of work assigned to an individual; such as "turn in
  # travel expense today".
  class Todo < Component
    component :alarms

    # Single properties
    optional_single_property :ip_class
    optional_single_property :completed
    optional_single_property :created
    optional_single_property :description
    required_property :dtstamp, :timestamp
    required_property :dtstart, :start
    optional_single_property :geo
    optional_single_property :last_modified
    optional_single_property :location
    optional_single_property :organizer
    optional_single_property :percent_complete, :percent
    optional_single_property :priority
    optional_single_property :recurid, :recurrence_id
    optional_single_property :sequence, :seq
    optional_single_property :status
    optional_single_property :summary
    required_property :uid, :user_id
    optional_single_property :url
    
    # Single but mutually exclusive TODO: not testing anything yet
    optional_single_property :due
    optional_single_property :duration
    mutually_exclusive_poperties :due, :duration

    # Multi-properties
    optional_property :attach, :attachment, :attachments
    optional_property :attendee, :attendee, :attendees
    optional_property :categories, :category, :categories
    optional_property :comment, :comment, :comments
    optional_property :contact, :contact, :contacts
    optional_property :exdate, :exception_date, :exception_dates
    optional_property :exrule, :exception_rule, :exception_rules
    optional_property :rstatus, :request_status, :request_statuses
    optional_property :related_to, :related_to, :related_tos
    optional_property :resources, :resource, :resources
    optional_property :rdate, :recurrence_date, :recurrence_dates
    optional_property :rrule, :recurrence_rule, :recurrence_rules
    
    def initialize()
      super("VTODO")

      sequence 0
      timestamp DateTime.now
    end

  end
end