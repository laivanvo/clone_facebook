# app/workers/hard_worker.rb
class NoticePostPending
  include Sidekiq::Worker

  def perform
    MemberRelation.admin.each do |admin_relation|
      UserMailer.notice_pending_post(admin_relation).deliver_later
    end
  end
end
