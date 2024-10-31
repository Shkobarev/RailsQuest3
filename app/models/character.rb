class Character < ApplicationRecord
  TEAMS_FOR_UNITS = {
    knight: 1,
    mage: 1,
    medusa: 2,
    jinn: 2
  }

  validates :team, presence: true
  validates :unit, presence: true
  validates :unit, acceptance: { accept: ['mage', 'knight', 'medusa', 'jinn']}
  validate :correct_team

  before_validation :set_team

  private
  def correct_team
    errors.add(:unit, "Unit shoild match team") unless TEAMS_FOR_UNITS[unit.to_sym] == team
  end

  def set_team
    self.team = TEAMS_FOR_UNITS[unit.to_sym] if self.team.nil?
  end
end  