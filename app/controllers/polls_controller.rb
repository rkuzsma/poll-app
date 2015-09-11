class PollsController < ApplicationController
  # GET /polls/new
  def new
    @poll = Poll.new
    @poll.group_a = [true,false].sample
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll[:live] = is_live_setting

    if @poll.save
      render :thanks
    else
      render :oops
    end
  end

  def results
    @polls = Poll.where(live: is_live_setting)
    group_a = {count: 0, sum: 0, points: Array.new(100){ |i| 0 }, anchor_percent: 3}
    group_b = {count: 0, sum: 0, points: Array.new(100){ |i| 0 }, anchor_percent: 65}
    @groups = [group_a, group_b]
    
    @polls.each do |poll|
      group = poll.group_a ? group_a : group_b
      group[:points][poll.value] += 1
      group[:count] += 1
      group[:sum] += poll.value
    end
    
    [group_a,group_b].each do |group|
      if group[:count] > 0
        group[:mean] = group[:sum] / group[:count]
      end
    end
    
    render :results
  end
  
  private
  
    def is_live_setting
      setting = Setting.where(name: 'is_live').first_or_create
      !!setting[:value]
    end
    
    def poll_params
      params.require(:poll).permit(:group_a, :value)
    end
end
