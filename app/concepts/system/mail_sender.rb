class MailSender
  def self.send(emails)
    emails.split(',').map(&:strip).each do |email|
      puts email.invalid_email?
    end
  end
end

MailSender.send("max@synthmax.dk, test03@synthmax.dk")