class Run < ActiveRecord::Base
  has_many :user_runs
  has_many :users, :through => :user_runs

  def self.create_run(name, invitees)
    invitees = invitees.gsub(" ","").split(",")
    run = Run.new
    run.name = name
    run.save!
    #create a user_run for the run creator and set status to "confirmed" √
    UserRun.create_user_run(run.id, current_user.id, "confirmed")
    invitees.each do |invitee|
      unless User.find_by_name(invitee)
        User.create_invited_user(invitee)
        #create a user for each invitee who isnt already a user
        # ^^ (with their name being their twitter name) and set their user status
        # ^^ to "invited"
      end
      #create a user_run for each invitee and set status to "invited"
      user = User.find_by_name(invitee)
      UserRun.create_user_run(run.id, user.id, "invited")
      #tweet to all invited users of the run
    end


  end
end
