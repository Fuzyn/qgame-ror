require 'rails_helper'

RSpec.describe MessagesHelper, type: :helper do
  let(:user) { create(:user) }
  let(:record) { create(:send_fleet_queue, user: user, planet: user.planets.first, galaxy: 1, solar_system: 1, planet_position: 1, metal_resource: 100, crystal_resource: 50, deuterium_resource: 25) }

  describe 'create_new_fleet_message' do
    context 'when travel type is transport and direction is to' do
      it 'creates a transport message' do
        record.travel_type = UserMessage::TRANSPORT_KEY
        record.direction = 'to'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("The transport has reached destination")
        expect(message.message).to eq("Your transport has reached the coordinates: 1:1:1 with resources: Metal - 100, Crystal - 50, Deuter - 25")
        expect(message.message_type).to eq(UserMessage::TRANSPORT_KEY)
      end
    end

    context 'when travel type is attack and direction is to' do
      it 'creates an attack message' do
        record.travel_type = UserMessage::ATTACK_KEY
        record.direction = 'to'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Successful attack")
        expect(message.message).to eq("Your attack has landed to: 1:1:1")
        expect(message.message_type).to eq(UserMessage::ATTACK_KEY)
      end
    end

    context 'when travel type is spy and direction is to' do
      it 'creates a spy message' do
        record.travel_type = UserMessage::SPY_KEY
        record.direction = 'to'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("You found out something!")
        expect(message.message).to eq("Your scout has reached the coordinates: 1:1:1")
        expect(message.message_type).to eq(UserMessage::SPY_KEY)
      end
    end

    context 'when travel type is expedition and direction is to' do
      it 'creates an expedition message' do
        record.travel_type = UserMessage::EXPEDITION_KEY
        record.direction = 'to'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Successful expedition")
        expect(message.message).to eq("Your expedition has reached the coordinates: 1:1:1")
        expect(message.message_type).to eq(UserMessage::EXPEDITION_KEY)
      end
    end

    context 'when travel type is colonize and direction is to' do
      it 'creates a colonization message' do
        record.travel_type = UserMessage::COLONIZE_KEY
        record.direction = 'to'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("You have settled a new planet")
        expect(message.message).to eq("The colonization mission reached its destination on coordinates: 1:1:1")
        expect(message.message_type).to eq(UserMessage::COLONIZE_KEY)
      end
    end

    context 'when travel type is transport and direction is back' do
      it 'creates a transport return message' do
        record.travel_type = UserMessage::TRANSPORT_KEY
        record.direction = 'back'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Transport is back")
        expect(message.message).to eq("The transport reached its destination and returned to the home planet")
        expect(message.message_type).to eq(UserMessage::TRANSPORT_KEY)
      end
    end

    context 'when travel type is attack and direction is back' do
      it 'creates an attack return message' do
        record.travel_type = UserMessage::ATTACK_KEY
        record.direction = 'back'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Attacking fleet has returned")
        expect(message.message).to eq("Your attack reached its destination and returned to the home planet")
        expect(message.message_type).to eq(UserMessage::ATTACK_KEY)
      end
    end

    context 'when travel type is spy and direction is back' do
      it 'creates an spy return message' do
        record.travel_type = UserMessage::SPY_KEY
        record.direction = 'back'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Spy fleet has returned")
        expect(message.message).to eq("Your spy fleet reached its destination and returned to the home planet")
        expect(message.message_type).to eq(UserMessage::SPY_KEY)
      end
    end

    context 'when travel type is expedition and direction is back' do
      it 'creates an expedition return message' do
        record.travel_type = UserMessage::EXPEDITION_KEY
        record.direction = 'back'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Expedition has returned")
        expect(message.message).to eq("Your expedition fleet reached its destination and returned to the home planet")
        expect(message.message_type).to eq(UserMessage::EXPEDITION_KEY)
      end
    end

    context 'when travel type is colonize and direction is back' do
      it 'creates an colonize return message' do
        record.travel_type = UserMessage::COLONIZE_KEY
        record.direction = 'back'
        message = create_new_fleet_message(record)

        expect(message.user).to eq(user)
        expect(message.title).to eq("Colonizing fleet has returned")
        expect(message.message).to eq("Your colonizing fleet reached its destination and returned to the home planet")
        expect(message.message_type).to eq(UserMessage::COLONIZE_KEY)
      end
    end
  end
end
