class Poll < ActiveRecord::Base
  attr_reader :anchor_percent
  
  def anchor_percent
    if self.group_a
      3
    else
      65
    end
  end
end
