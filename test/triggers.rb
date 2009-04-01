trigger "test_trigger" do
  runs  { "hello world" }
  on    :monday
  at    :hour=>3, :minute=>10  
end

trigger "test_trigger_2" do
  runs  { "hello world 2" }
  on    :tuesday
  every 2=>:hours, 10=>:minutes
end