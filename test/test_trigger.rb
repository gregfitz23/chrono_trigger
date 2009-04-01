class TestTrigger < Test::Unit::TestCase
  
  context "A Trigger, @trigger," do
    setup do
      @trigger = ChronoTrigger::Trigger.new
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
    end #and a block of code to run
  end #A Trigger, @trigger,
  
end