module MessagesHelper
  include NotificationHelper

  def create_new_fleet_message(record)
    title = ""
    message = ""
    key = nil

    if record.direction == 'to'
      if record.travel_type == UserMessage::TRANSPORT_KEY
        title = "The transport has reached destination"
        message = "Your transport has reached the coordinates: #{record.galaxy}:#{record.solar_system}:#{record.planet_position} with resources: Metal - #{record.metal_resource}, Crystal - #{record.crystal_resource}, Deuter - #{record.deuterium_resource}"
        key = UserMessage::TRANSPORT_KEY
      elsif record.travel_type == UserMessage::ATTACK_KEY
        title = "Successful attack"
        message = "Your attack has landed to: #{record.galaxy}:#{record.solar_system}:#{record.planet_position}"
        key = UserMessage::ATTACK_KEY
      elsif record.travel_type == UserMessage::SPY_KEY
        title = "You found out something!"
        message = "Your scout has reached the coordinates: #{record.galaxy}:#{record.solar_system}:#{record.planet_position}"
        key = UserMessage::SPY_KEY
      elsif record.travel_type == UserMessage::EXPEDITION_KEY
        title = "Successful expedition"
        message = "Your expedition has reached the coordinates: #{record.galaxy}:#{record.solar_system}:#{record.planet_position}"
        key = UserMessage::EXPEDITION_KEY
      elsif record.travel_type == UserMessage::COLONIZE_KEY
        title = "You have settled a new planet"
        message = "The colonization mission reached its destination on coordinates: #{record.galaxy}:#{record.solar_system}:#{record.planet_position}"
        key = UserMessage::COLONIZE_KEY
      end
    else
      if record.travel_type == UserMessage::TRANSPORT_KEY
        title = "Transport is back"
        message = "The transport reached its destination and returned to the home planet"
        key = UserMessage::TRANSPORT_KEY
      elsif record.travel_type == UserMessage::ATTACK_KEY
        title = "Attacking fleet has returned"
        message = "Your attack reached its destination and returned to the home planet"
        key = UserMessage::ATTACK_KEY
      elsif record.travel_type == UserMessage::SPY_KEY
        title = "Spy fleet has returned"
        message = "Your spy fleet reached its destination and returned to the home planet"
        key = UserMessage::SPY_KEY
      elsif record.travel_type == UserMessage::EXPEDITION_KEY
        title = "Expedition has returned"
        message = "Your expedition fleet reached its destination and returned to the home planet"
        key = UserMessage::EXPEDITION_KEY
      elsif record.travel_type == UserMessage::COLONIZE_KEY
        title = "Colonizing fleet has returned"
        message = "Your colonizing fleet reached its destination and returned to the home planet"
        key = UserMessage::COLONIZE_KEY
      end
    end

    create_message(record.user, title, message, key)
  end
end
