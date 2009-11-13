module MootoolsCalendar
  module CalendarFor
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def calendar_for(field, format = "%d/%m/%Y")
        send :define_method, "calendar_#{ field }" do
          record = send field.to_sym
          record.strftime(format) if record
        end

        send :define_method, "calendar_#{ field }=" do |date|
          begin
            date = date.split('/')
            send "#{ field }=", Date.civil(date[2].to_i, date[1].to_i, date[0].to_i)
          rescue
            send "#{ field }=", nil
          end
        end
      end
    end
  end

  module CalendarHelper
    def initialize_calendar(fields, format)
      str = "<script type='text/javascript'>"
      str << "window.addEvent('domready', function() { "
      fields.each_with_index do |field, i|
        str << "myCal#{ i } = new Calendar({ #{ field }: '#{ format }' }, { direction: 1, tweak: { x: 6, y: 0 }});"
      end
      str << "});"
      str << "</script>"
    end
  end
end

