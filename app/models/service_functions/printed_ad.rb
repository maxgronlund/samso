# Ad for the printed paper

class ServiceFunctions::PrintedAd < ApplicationRecord
  PENDING = 'pending'.freeze
  RECEIVED = 'received'.freeze
  REJECTED = 'rejected'.freeze
  APPROVED = 'approved'.freeze
  PRINTED = 'printed'.freeze

  STATES = [
    [PENDING, I18n.t('printed_ad.' + PENDING)],
    [RECEIVED, I18n.t('printed_ad.' + RECEIVED)],
    [APPROVED, I18n.t('printed_ad.' + APPROVED)],
    [REJECTED, I18n.t('printed_ad.' + REJECTED)],
    [PRINTED, I18n.t('printed_ad.' + PRINTED)]
  ].freeze
end
