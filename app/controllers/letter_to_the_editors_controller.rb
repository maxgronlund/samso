class LetterToTheEditorsController < ApplicationController
  def index
  	@message = Admin::SystemMessage.letter_to_the_edditors
  	ap admin_system_setup
  	@emails = admin_system_setup.editor_emails.split(',')
  end
end
