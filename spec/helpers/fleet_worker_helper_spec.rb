require 'rails_helper'

RSpec.describe FleetWorkerHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { create(:planet, user: user, metal_resource: 1000, crystal_resource: 1000, deuterium_resource: 1000) }
  let(:planet_2) { create(:planet, user: user, metal_resource: 1000, crystal_resource: 1000, deuterium_resource: 1000) }
  let(:fleet_record) { create(:send_fleet_queue, user: user, planet: planet_2, direction: 'to', travel_type: 'transport', galaxy: planet.galaxy, solar_system: planet.solar_system, planet_position: planet.planet_position, metal_resource: 1000, crystal_resource: 1000, deuterium_resource: 1000, cruiser: 2, light_fighter: 1) }

  describe '#execute_sent_fleet' do
    context 'when direction is to' do
      context 'and travel type is transport' do
        it 'calls transport and turns fleet around' do
          helper.execute_sent_fleet(fleet_record)

          planet.reload
          fleet_record.reload

          expect(fleet_record.direction).to eq('from')
          expect(planet.metal_resource).to eq(2000)
          expect(planet.crystal_resource).to eq(2000)
          expect(planet.deuterium_resource).to eq(2000)
        end
      end

      context 'and travel type is attack' do
        before { fleet_record.update(travel_type: 'attack') }

        it 'calls attack and turns fleet around' do
          helper.execute_sent_fleet(fleet_record)

          fleet_record.reload

          expect(fleet_record.direction).to eq('from')
        end
      end

      context 'and travel type is spy' do
        before { fleet_record.update(travel_type: 'spy') }

        it 'calls spy and turns fleet around' do
          helper.execute_sent_fleet(fleet_record)

          fleet_record.reload

          expect(fleet_record.direction).to eq('from')
        end
      end

      context 'and travel type is expedition' do
        before { fleet_record.update(travel_type: 'expedition') }

        it 'calls expedition and turns fleet around' do
          helper.execute_sent_fleet(fleet_record)

          fleet_record.reload

          expect(fleet_record.direction).to eq('from')
        end
      end

      context 'and travel type is colonize' do
        before {
          fleet_record.update(travel_type: 'colonize')
          fleet_record.update(galaxy: 1)
          fleet_record.update(solar_system: 1)
          fleet_record.update(planet_position: 1)
        }

        it 'calls colonize and creates a new planet' do
          expect { helper.execute_sent_fleet(fleet_record) }.to change { user.planets.count }.by(1)

          new_planet = Planet.last
          fleet_record.reload

          expect(fleet_record.direction).to eq('from')
          expect(new_planet.galaxy).to eq(1)
          expect(new_planet.solar_system).to eq(1)
          expect(new_planet.planet_position).to eq(1)
        end
      end
    end

    context 'when direction is from' do
      before { fleet_record.update(direction: 'from') }

      it 'marks the record as deleted' do
        expect(fleet_record.deleted).to be_falsey

        helper.execute_sent_fleet(fleet_record)

        fleet_record.reload
        expect(fleet_record.deleted).to be_truthy
      end
    end
  end

  describe '#turn_fleet_around' do
    it 'changes the fleet direction to from, sets new coordinates' do
      helper.execute_sent_fleet(fleet_record)

      expect(fleet_record.galaxy).to eq(planet_2.galaxy)
      expect(fleet_record.solar_system).to eq(planet_2.solar_system)
      expect(fleet_record.planet_position).to eq(planet_2.planet_position)
      expect(fleet_record.direction).to eq('from')
    end
  end

  describe '#return_fleet' do
    before {
      fleet_record.update(travel_type: 'spy')
      fleet_record.update(direction: 'from')
      planet_2.planet_fleet.update_attribute(:light_fighter, 1)
    }

    it 'returns the fleet to the planet and restores resources' do
      helper.execute_sent_fleet(fleet_record)

      planet_2.reload
      fleet_record.reload

      expect(fleet_record.deleted).to eq(true)
      expect(planet_2.metal_resource).to eq(2000)
      expect(planet_2.crystal_resource).to eq(2000)
      expect(planet_2.deuterium_resource).to eq(2000)
      expect(planet_2.planet_fleet.cruiser).to eq(2)
      expect(planet_2.planet_fleet.light_fighter).to eq(2)
    end
  end
end
