# Ad for the printed paper

class ServiceFunctions::PrintedAd < ApplicationRecord
  PENDING = 'pending'.freeze
  RECEIVED = 'received'.freeze
  REJECTED = 'rejected'.freeze
  APPROVED = 'approved'.freeze
  PRINTED = 'printed'.freeze

  STATES = [
    [I18n.t('ads.' + PENDING), PENDING],
    [I18n.t('ads.' + RECEIVED), RECEIVED],
    [I18n.t('ads.' + APPROVED), APPROVED],
    [I18n.t('ads.' + REJECTED), REJECTED],
    [I18n.t('ads.' + PRINTED), PRINTED]
  ].freeze
end
