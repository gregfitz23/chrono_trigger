class TestShell < Test::Unit::TestCase
  
  context "A shell instance, @shell" do
    setup do
      @shell = ChronoTrigger::Shell.new
    end
    
    should "return an empty array on call to triggers" do
      assert_equal [], @shell.triggers
    end

    should "raise an exception unless a block is provided to #trigger" do
      assert_raise(ChronoTrigger::ConfigurationException) { @shell.trigger("test trigger") }
    end

    context "when provided a valid block" do
      setup do
        @trigger = @shell.trigger("name") { runs { "x" } }
      end
      
      should "create a new trigger" do
        assert_equal 1, @shell.triggers.size
      end
      
      should "create a trigger that will run x with execute" do
        assert_equal "x", @shell.triggers.first.execute
      end
      
      context "and configured to run the next time shell.execute_triggers is called" do
        setup do
          ChronoTrigger::CronEntry.any_instance.stubs(:matches?).returns(true)
        end
        
        should "execute the code block" do
          @trigger.expects(:execute)
          @shell.execute_triggers
        end
      end #and configured to run the next time shell.execute_triggers is called
    end #when provided a valid block
    
    context "calling load_context with a valid trigger file" do
      setup do
        @shell.load_triggers("test/triggers.rb")
      end
      
      should "create 2 triggers" do
        assert_equal 2, @shell.triggers.size
      end
    end #calling load_context with a valid trigger file
  end #A shell instance, @shell
  
end