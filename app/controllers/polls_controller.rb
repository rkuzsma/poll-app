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

    if @poll.save
      render :thanks
    else
      render :oops
    end
  end

  def results
    @polls = Poll.all
    group_a = {count: 0, sum: 0, anchor_percent: 3}
    group_b = {count: 0, sum: 0, anchor_percent: 65}
    @groups = [group_a, group_b]
    
    @polls.each do |poll|
      group = poll.group_a ? group_a : group_b
      group[:count] += 1
      group[:sum] += poll.value
    end
    [group_a,group_b].each do |group|
      group[:mean] = group[:sum] / group[:count]
    end
    
    render :results
  end
  
  private
    def poll_params
      params.require(:poll).permit(:group_a, :value)
    end
end
