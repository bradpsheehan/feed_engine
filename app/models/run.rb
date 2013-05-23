class Run < ActiveRecord::Base
  has_many :user_runs
  has_many :users, :through => :user_runs
  has_many :activities
  belongs_to :route

  delegate :name, :path, :path_points, to: :route, prefix: true

  attr_accessible :organizer_id, :started_at, :route_id,
                  :name, :details

  def self.create_with_invitees(invitees, run_info)
    run = Run.create(run_info)
    run.invite_runners(invitees)
    run
  end

  def self.fuzzy_find(params)
    user = params[:user]
    time = params[:started_at]

    dataset = user.runs.where("started_at >= ?", (time-fuzzy_find_buffer))
    dataset.where("started_at <= ?", (time+fuzzy_find_buffer)).first
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
    confirmed_user_runs = user_runs.select {|ur| ur.status == "confirmed"}
    confirmed_user_runs.collect(&:user) << organizer
  end

  def cancel
    self.cancelled = true
    save
  end

  def over?
    started_at+over_buffer < Time.now
  end

  private

  def self.fuzzy_find_buffer
    15*60
  end

  def over_buffer
    5*60*60
  end

  def add_invitee(invitee_name)
    user = User.find_or_create_by_name(name: invitee_name, status: "invited")
    user_run = user_runs.create(user_id: user.id, status: "invited")
    OutstandingTwitterInvites.create_invite(organizer, user,
                                            user_run.id, started_at)
  end

  def send_invite(invitee_name)
    begin
      t = "@#{invitee_name} reply #yes to run with me on"
      t += " #{started_at} via #runline"
      organizer.tweet(t)
    rescue

    end
  end
end
