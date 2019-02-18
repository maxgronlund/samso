class LetterToTheEditorsController < ApplicationController
  def index
  	@message = Admin::SystemMessage.letter_to_the_edditors
  	@emails = admin_system_setup.editor_emails.split(',')
  end
end
