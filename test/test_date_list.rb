class TestDateList < Test::Unit::TestCase
  
  context "A DateGroup, @date_group," do
    setup do
      @date_list = ChronoTrigger::DateList.new
    end

    context "on a call to set_days for Monday" do
      setup do
        @date_list.set_days(:monday)
        @date = @date_list.dates.first
      end
      
      should "add a date, with year -4972" do
        assert_equal Date.civil.year, @date.year
      end
      
      should "add"
    end #on a call to setDays for Monday
  end #A DateGroup, @date_group,
  
end