trigger "trigger1" do
  runs { puts "trigger 1 runs every 1 minutes; executed at #{Time.now}"}
  every :minutes=>1  
end

trigger "trigger2" do
  runs { puts "trigger 2 runs every 5 minutes; executed at #{Time.now}"}
  every :minutes=>5
end

trigger "trigger3" do 
  runs  { puts "trigger 3 runs at 9:48; executed at #{Time.now}"}
  at    :hour=>9, :minute=>48
end

trigger "trigger4" do
  runs { puts "trigger 4 runs on monday at 9:53 and 9:56; executed at #{Time.now}"}
  on    :monday
  at    :hour=>9, :minute=>[53, 56]
end

trigger "trigger5" do
  runs  { puts "trigger 5 runs on thursday at 9:58/59; executed at #{Time.now}"}
  on    :thursday
  at    :hour=>9, :minute=>[58, 59]
end