module ChronoTrigger
  class DateList

    def set_days(*days)
      days.map! (&:to_sym)
      
    end

    def dates
     @dates ||= []
    end 

  end
end