require 'mootools_calendar'
ActiveRecord::Base.send :include, MootoolsCalendar::CalendarFor
ActionView::Base.send :include, MootoolsCalendar::CalendarHelper