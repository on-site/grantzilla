require "rails_helper"

describe CommentsMailer, type: :mailer do
  describe '#comment_mail' do
    let(:admin) { create(:user, :admin) }
    let(:case_worker) { create(:user, :case_worker) }
    let(:comment) { grant.comments.create(body: "This is a test.", user: case_worker) }
    let(:grant) { create(:grant, user: case_worker) }
    let(:mail) { CommentsMailer.comment_email(comment, admin) }
    let(:text_source) { mail.body.parts.first.body.raw_source.to_s }
    let(:html_source) { mail.body.parts.last.body.raw_source.to_s }

    before do
      allow_any_instance_of(Comment).to receive(:notify_users).and_return(true)
      grant.people.build(first_name: "Fred", last_name: "Flintstone")
    end

    it "renders the subject" do
      expect(mail.subject).to eql("New comment on grant for Fred Flintstone")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([admin.email])
    end

    it "includes both html and text parts" do
      expect(mail.body.parts.size).to eq(2)
    end

    it "includes the comment" do
      expect(text_source).to include(comment.body)
      expect(html_source).to include(comment.body)
    end

    context "when there are no previous comments" do
      it "shouldn't include a section for previous comments" do
        expect(text_source).to_not include("Previous")
        expect(html_source).to_not include("Previous")
      end
    end

    context "when there are previous comments" do
      let!(:old_comment) { grant.comments.create(body: "Entered before", user: admin) }
      it "should include a section for previous comments" do
        expect(text_source).to include("Previous")
        expect(text_source).to include(old_comment.body)
        expect(html_source).to include("Previous")
        expect(html_source).to include(old_comment.body)
      end
    end
  end
end
