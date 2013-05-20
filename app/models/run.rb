class Run < ActiveRecord::Base
  has_many :user_runs
  has_many :users, :through => :user_runs
  belongs_to :route

	delegate :name, :path, to: :route, prefix: true

  attr_accessible :organizer_id, :run_date, :run_start_time, :route_id,
                  :name, :details

  def self.create_with_invitees(invitees, run_info)
    run = Run.create(run_info)
    run.invite_runners(invitees)
    run
  end

  def organizer
    @organizer ||= User.find_by_id(organizer_id)
  end

  def invite_runners(invitee_names)
    invitee_names.each do |invitee_name|
      invite_runner(invitee_name)
    end
  end

  def invite_runner(invitee_name)
    add_invitee(invitee_name)
    send_invite(invitee_name)
  end

  def confirmed_runners
    confirmed_user_runs = user_runs.select {|user_run| user_run.status == "confirmed"}
    confirmed_user_runs.collect(&:user) << organizer
  end

  private

  def add_invitee(invitee_name)
    user = User.find_or_create_by_name(name: invitee_name, status: "invited")
    user_run = user_runs.create(user_id: user.id, status: "invited")
    OutstandingTwitterInvites.create_invite(organizer, user,
                                            user_run.id, run_date)
  end

  def send_invite(invitee_name)
    begin
      organizer.tweet("@#{invitee_name} reply #yes to come run with me on #{run_date}")
    rescue
      organizer.tweet("@#{invitee_name} reply #yes to come run with me on #{run_date} #{rand(0..9999)}")
    end
  end


  # def invite_runners(run_creator, run, invitees)
  #   invitees = invitees.gsub(" ","").split(",")

  #   invitees.each do |invitee|
  #     unless User.find_by_name(invitee)
  #       User.create_invited_user(invitee)
  #     end
  #     user = User.find_by_name(invitee)
  #     user_run = UserRun.create(run.id, user.id, "invited")
  #     OutstandingTwitterInvites.create_invite(
  #       run_creator,
  #       user,
  #       user_run.id,
  #       run.run_date
  #       )
  #     run_creator.tweet("@#{user.name} reply #yes to come run with me #{rand(0..9999)}")
  #   end
  # end

end
