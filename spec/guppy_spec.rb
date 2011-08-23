require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Guppy" do

  before(:all) do
    @parser = Guppy::Parser.new(File.open('spec/data/example.tcx'))
  end

  it "should parse activities from a .tcx file" do
    activities = @parser.activities
    activities.size.should eql(1)

    activity = activities.first
    activity.activity_type.should eql('Cycling')
    activity.started_at.to_s.should eql('2011-08-11 12:22:30 UTC')
    activity.elapsed_time.should eql(3584.205133)
    activity.distance.should eql(25430.767578)
    activity.avg_speed.should eql(7.1054)
    activity.max_speed.should eql(9.9909)
    activity.calories_burned.should eql(1347)
    activity.avg_heart_rate.should eql(168)
    activity.max_heart_rate.should eql(180)
    activity.avg_cadence.should eql(75)
    activity.max_cadence.should eql(126)
  end

  it "should parse activities from a .tcx file" do
    laps = @parser.activities.first.laps
    laps.size.should eql(2)

    lap = laps[0]
    lap.started_at.to_s.should eql('2011-08-11 12:22:30 UTC')
    lap.elapsed_time.should eql(1873.007201)
    lap.distance.should eql(12888.303711)
    lap.avg_speed.should eql(6.8811)
    lap.max_speed.should eql(10.200533)
    lap.calories_burned.should eql(680)
    lap.avg_heart_rate.should eql(168)
    lap.max_heart_rate.should eql(185)
    lap.avg_cadence.should eql(71)
    lap.max_cadence.should eql(96)

    lap = laps[1]
    lap.started_at.to_s.should eql('2011-08-11 12:53:43 UTC')
    lap.elapsed_time.should eql(1711.197932)
    lap.distance.should eql(12542.463867)
    lap.avg_speed.should eql(7.3296)
    lap.max_speed.should eql(9.781333)
    lap.calories_burned.should eql(667)
    lap.avg_heart_rate.should eql(168)
    lap.max_heart_rate.should eql(176)
    lap.avg_cadence.should eql(79)
    lap.max_cadence.should eql(157)
  end

end
