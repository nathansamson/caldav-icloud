

module Icalendar
  # A Event calendar component is a grouping of component
  # properties, and possibly including Alarm calendar components, that
  # represents a scheduled amount of time on a calendar. For example, it
  # can be an activity; such as a one-hour long, department meeting from
  # 8:00 AM to 9:00 AM, tomorrow. Generally, an event will take up time
  # on an individual calendar.
  class Event < Component
    component :alarms

    ## Single instance properties

    # Access classification (PUBLIC, PRIVATE, CONFIDENTIAL...)
    optional_single_property :ip_class, :klass

    # Date & time of creation
    optional_single_property :created

    # Complete description of the calendar component
    optional_single_property :description

    attr_accessor :tzid

    # Specifies date-time when calendar component begins
    required_property :dtstart
    # dtstart only required if calendar's method is nil
    #required_property :dtstart, Icalendar::Values::DateTime,
                      #->(event, dtstart) { !dtstart.nil? || !(event.parent.nil? || event.parent.ip_method.nil?) }
    optional_single_property :start

    # Latitude & longitude for specified activity
    optional_single_property :geo, :geo_location

    # Date & time this item was last modified
    optional_single_property :last_modified

    # Specifies the intended venue for this activity
    optional_single_property :location

    # Defines organizer of this item
    optional_single_property :organizer

    # Defines relative priority for this item (1-9... 1 = best)
    optional_single_property :priority

    # Indicate date & time when this item was created
    # required_property :dtstamp, Icalendar::Values::DateTime
    required_property :dtstamp
    optional_single_property :timestamp

    # Revision sequence number for this item
    optional_single_property :sequence, :seq

    # Defines overall status or confirmation of this item
    optional_single_property :status
    optional_single_property :summary
    optional_single_property :transp, :transparency

    # Defines a persistent, globally unique id for this item
    required_property :uid, :unique_id

    # Defines a URL associated with this item
    optional_single_property :url
    optional_single_property :recurrence_id, :recurid

    ## Single but mutually exclusive properties (Not testing though)

    # Specifies a date and time that this item ends
    optional_single_property :dtend, :end

    # Specifies a positive duration time
    optional_single_property :duration

    ## Multi-instance properties

    # Associates a URI or binary blob with this item
    optional_property :attach, :attachment, :attachments

    # Defines an attendee for this calendar item
    ical_multiline_property :attendee, :attendee, :attendees

    # Defines the categories for a calendar component (school, work...)
    optional_property :categories, :category, :categories

    # Simple comment for the calendar user.
    optional_property :comment, :comment, :comments

    # Contact information associated with this item.
    optional_property :contact, :contact, :contacts
    optional_property :exdate, :exception_date, :exception_dates
    optional_property :exrule, :exception_rule, :exception_rules
    optional_property :rstatus, :request_status, :request_statuses

    # Used to represent a relationship between two calendar items
    optional_property :related_to, :related_to, :related_tos
    optional_property :resources, :resource, :resources

    # Used with the UID & SEQUENCE to identify a specific instance of a
    # recurring calendar item.
    optional_property :rdate, :recurrence_date, :recurrence_dates
    optional_property :rrule, :recurrence_rule, :recurrence_rules

    def initialize()
      super("VEVENT")

      # Now doing some basic initialization
      sequence 0
      timestamp DateTime.now
    end

    def alarm(&block)
      a = Alarm.new
      self.add a

      a.instance_eval(&block) if block

      a
    end

    def occurrences_starting(time)
      recurrence_rules.first.occurrences_of_event_starting(self, time)
    end

  end
end