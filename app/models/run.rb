class Run < ActiveRecord::Base
  has_many :user_runs
  has_many :users, :through => :user_runs

  def self.create_with_creator_and_invitees(run_creator, name, invitees)
    run = Run.new
    run.name = name
    run.save!
    #create a user_run for the run creator and set status to "confirmed" √
    # UserRun.create(run.id, run_creator.id, "confirmed")
    run.user_runs.create(user_id: run_creator.id, status: "confirmed")
    invite_runners(run_creator, run, invitees)
  end

private
  def self.invite_runners(run_creator, run, invitees)
    invitees = invitees.gsub(" ","").split(",")

    invitees.each do |invitee|
      unless User.find_by_name(invitee)
        User.create_invited_user(invitee)
      end
      user = User.find_by_name(invitee)
      # UserRun.create(run.id, user.id, "invited")
      run.user_runs.create(user_id: user.id, status: "invited")

      #tweet to all invited users of the run
      run_creator.tweet("@#{user.name} reply #yes to come run with me! #{rand(0..9999)}")
    end
  end
end
