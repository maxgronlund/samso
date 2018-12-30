# frozen_string_literal: true

class Admin::Footer < ApplicationRecord

  def about_page
    @about_page ||= Page.find_by(id: about_page_id)
  end

  def copyright_page
    @copyright_page ||= Page.find_by(id: copyright_page_id)
  end

  def term_of_usage_page
    @term_of_usage_page ||= Page.find_by(id: term_of_usage_page_id)
  end


end



    #                           :id => :integer,
    #                        :title => :string,
    #                       :locale => :string,
    #                :about_page_id => :integer,
    #         :about_page_link_name => :string,
    #            :copyright_page_id => :integer,
    #                      :integer => :integer,
    #     :copyright_page_link_name => :string,
    #        :term_of_usage_page_id => :integer,
    # :term_of_usage_page_link_name => :string,
    #                        :email => :string,
    #                 :company_name => :string,
    #                        :phone => :string,
    #                       :vat_nr => :string,
    #                   :created_at => :datetime,
    #                   :updated_at => :datetime