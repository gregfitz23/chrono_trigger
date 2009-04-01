class TestShell < Test::Unit::TestCase
  
  context "A shell instance, @shell" do
    setup do
      @shell = ChronoTrigger::Shell.new
    end
    
    should "return an empty array on call to triggers" do
      assert_equal [], @shell.triggers
    end

    should "raise an exception unless a block is provided to #trigger" do
      assert_raise(ChronoTrigger::ConfigurationException) { @shell.trigger }
    end

    context "when provided a valid block" do
      setup do
        @shell.trigger { runs { "x" } }
      end
      
      should "create a new trigger" do
        assert_equal 1, @shell.triggers.size
      end
      
      should "create a trigger that will run x with execute" do
        assert_equal "x", @shell.triggers.first.execute
      end
    end #when provided a valid block
  end #A shell instance, @shell
  
end