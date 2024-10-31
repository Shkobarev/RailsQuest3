class HomeController < ApplicationController

def index
  @team1 = Character.where(team: 1)
  @team2 = Character.where(team: 2)
end

def add_unit
  id = params[:id]
  case id.to_i
  when 1
    @character = Character.new(unit: 'mage', team: 1)
  when 2
    @character = Character.new(unit: 'knight', team: 1)
  when 3
    @character = Character.new(unit: 'medusa', team: 2)
  when 4
    @character = Character.new(unit: 'jinn', team: 2)
  end

  if @character.save
    redirect_to '/'
  else
    render plain: "Error: #{@character.errors.full_messages.join(', ')}"
  end
end

def ultimate
  id = params[:id]
  case id.to_i
  when 1
    mage_count = Character.where(team: 1, unit: 'mage').count
    knight_count = Character.where(team: 1, unit: 'knight').count
    if mage_count >= 2 && knight_count >= 2
      5.times do
        Character.create(unit: 'knight', team: 1)
      end
    end

  when 2
    jinn_count = Character.where(team: 2, unit: 'jinn').count
    medusa_count = Character.where(team: 2, unit: 'medusa').count

    if jinn_count >= 2 && medusa_count >= 1
      count_unit_team1 = Character.where(team: 1).count
      if count_unit_team1 > 3
        3.times do
            random_unit = Character.where(team: 1).offset(rand(count_unit_team1)).first
            random_unit.destroy
            count_unit_team1 -= 1
        end
      else
        Character.where(team: 1).destroy_all
      end
    end
  end

  redirect_to '/'
end
end