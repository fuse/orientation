require 'spec_helper'
 
describe ArticleMailer do
  let(:user) { create(:user, email: 'aimee@envylabs.com') }
  
  context "notify_author_of_staleness" do
    let(:articles) { [create(:article, :stale, author: user)] }
    let(:mailer) { described_class.notify_author_of_staleness(articles) }

    subject { mailer }

    it { should send_email_to(email: user.email) }
    it { should use_template('Stale Article Alert') }
    it { should have_subject('Some of your Orientation articles might be stale') }
    it { should be_from(email: 'orientation@codeschool.com') }

  end

  context "send_updates_for(article, user)" do
    let(:article) { create(:article) }
    let(:mailer) { described_class.send_updates_for(article, user) }

    subject { mailer }

    it { should send_email_to(email: user.email) }
    it { should use_template('Article Subscription Update') }
    it { should have_subject('Article Subscription Update') }
    it { should be_from(email: 'orientation@codeschool.com') }

  end

end