require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:admin) { create(:user, :admin) }
  let(:case_worker) { create(:user, :case_worker) }
  let(:comments_mail) { double("comment_mail", deliver: true) }
  let(:grant) { create(:grant, user: case_worker) }

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

  describe "#context" do
    let(:comment) { grant.comments.create(user: admin, body: "Work work work work work.") }
    let(:context) { comment.context }
    before do
      allow(CommentsMailer).to receive(:comment_email).with(anything, anything).and_return(comments_mail)
    end
    context "when this is the only comment" do
      it "returns an empty list" do
        expect(context.size).to eq(0)
      end
    end
    context "when there are other comments" do
      let!(:comment1) { grant.comments.create(user: admin, body: "Hello?") }
      let!(:comment2) { grant.comments.create(user: case_worker, body: "How are you?") }
      it "returns only the other comments in reverse order" do
        expect(context.size).to eq(2)
        expect(context[0]).to eq(comment2)
        expect(context[1]).to eq(comment1)
      end
    end
  end
end
