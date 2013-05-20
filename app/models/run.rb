class Run < ActiveRecord::Base
  has_many :user_runs
  has_many :users, :through => :user_runs
  has_one :route

  def self.create_with_creator_and_invitees(run_creator, name, invitees, run_info=nil)
    run = Run.new
    run.name = name
    if run_info
      run.details = run_info[:details]
      run.route_id = run_info[:route_id]
      run.run_date = run_info[:run_date]
      run.run_start_time = run_info[:run_start_time]
    end
    run.save!
    #create a user_run for the run creator and set status to "confirmed" √
    run.user_runs.create(user_id: run_creator.id, status: "confirmed")
    invite_runners(run_creator, run, invitees)

    run
  end

private
  def self.invite_runners(run_creator, run, invitees)

    invitees.each do |invitee|
      unless User.find_by_name(invitee)
        User.create_invited_user(invitee)
      end
      user = User.find_by_name(invitee)
      run.user_runs.create(user_id: user.id, status: "invited")

      #tweet to all invited users of the run
      run_creator.tweet("@#{user.name} reply #yes to come run with me! #{rand(0..9999)}")
    end
  end
end
