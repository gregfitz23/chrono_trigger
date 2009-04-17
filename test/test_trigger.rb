class TestTrigger < Test::Unit::TestCase
  
  context "A Trigger, @trigger," do
    setup do
      @trigger = ChronoTrigger::Trigger.new("test trigger")
    end

    context "and a block of code to run" do
      setup do
        @block_to_run = "hello"
        @trigger.runs { @block_to_run }
      end

      should "assign @exec_block on call to runs" do
        assert_equal @block_to_run, @trigger.instance_variable_get(:@exec_block).call
      end
      
      should "execute @block_to_run on call to execute" do
        assert_equal @block_to_run, @trigger.execute
      end
      
      context "that raises an exception" do
        setup do
          @trigger.runs { raise Exception.new("test error")}
        end
        
        should "be caught and logged by the trigger" do
          assert_nothing_raised do
            quietly { @trigger.execute }
          end
        end
      end #that raises an exception
    end #and a block of code to run

    context "and a call to #on with some days" do
      setup do
        @days = [:monday, :wednesday]
        @expected_days = [1, 3]
        @trigger.on(@days)
      end
      
      should "set the triggers cron entry days" do
        assert_equal @expected_days, @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@days)
      end
    end #and a call to on with some days
    
    context "and a call to #at with :hours and :minutes" do
      setup do
        @hours = 10
        @minutes = 5
        @trigger.at :hour=>@hours, :minute=>@minutes
      end
      
      should "set the trigger's cron entry's hours" do
        assert_equal [@hours], @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@hours)
      end
      
      should "set the trigger's cron entry's minutes" do
        assert_equal [@minutes], @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@minutes)
      end
      
      context "that are nil" do
        setup do
          @hours, @minutes = nil, nil
        end
        
        should "raise an exception" do
          assert_raise ChronoTrigger::ConfigurationException do
            @trigger.at :hours=>@hours, :minutes=>@minutes
          end
        end
      end #that are nil
    end #and a call to #at with :hours and :minutes
    

    context "on a call to #every" do
      context "for 10 minutes" do
        setup do
          @minutes = 10
        end
      
        context "when called" do
          setup do          
            @trigger.every :minutes=>@minutes
          end
        
          should "set the trigger's cron entry's minutes to [0, 10,20,30,40,50]" do
            assert_equal [0,10,20,30,40,50], @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@minutes)
          end
          
          context "in addition to setting #at to hour 2" do
            setup do
              @hour = 2
              @trigger.at :hour=>@hour
            end
            
            should "set the trigger's cron entry's minutes to [0, 10,20,30,40,50]" do
              assert_equal [0,10,20,30,40,50], @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@minutes)
            end
            
            should "set the trigger's cron entry's hours to 2" do
              assert_equal [2], @trigger.instance_variable_get(:@cron_entry).instance_variable_get(:@hours)              
            end
          end #in addition to setting #{}
        end #when called
      end #for 10 minutes
      
      context "for 11 minutes" do
        setup do
          @minutes = 11
        end
        
        should "raise an exception" do
          assert_raise ChronoTrigger::ConfigurationException do
            @trigger.every :minutes=>@minutes
          end
        end
      end #for 11 minutes            
    end #on a call to #every      
    
    should "raise an exception on call to #every without minutes or hours" do
      assert_raise ChronoTrigger::ConfigurationException do
        @trigger.every()
      end
    end
  end #A Trigger, @trigger,
  
end