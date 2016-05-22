require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:case_worker) { create(:user, :case_worker) }
  let(:admin) { create(:user, :admin) }
  let(:grant) { create(:grant, user: case_worker) }
  let(:comments_mail) { double("comment_mail", deliver: true) }
  describe "#create" do
    context "when the comment is created by the admin" do
      it "sends an email to the case worker" do
        expect(CommentsMailer).to receive(:comment_email).with(anything, case_worker).and_return(comments_mail)
        grant.comments.create(user: admin, body: "Hello World")
      end
    end
    context "when the comment is created by the case worker" do
      before do
        admin
      end
      it "sends an email to the admin" do
        expect(CommentsMailer).to receive(:comment_email).with(anything, admin).and_return(comments_mail)
        grant.comments.create(user: case_worker, body: "Hello World")
      end
    end
  end
end
