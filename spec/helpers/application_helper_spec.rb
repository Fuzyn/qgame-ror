require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "Basic functions" do
    it 'basic_points' do
      expect(MetalMine.basic_points).to eq(400)
      expect(LightFighter.basic_points).to eq(1000)
      expect(LightIonCannon.basic_points).to eq(5000)
      expect(Buildings.basic_points).to be nil
      expect(Fleet.basic_points).to be nil
      expect(Defence.basic_points).to be nil
    end

    it 'basic_key' do
      expect(CrystalMine.basic_key).to eq('crystal_mine')
      expect(HeavyFighter.basic_key).to eq('heavy_fighter')
      expect(HeavyIonCannon.basic_key).to eq('heavy_ion_cannon')
      expect(Buildings.basic_key).to be nil
      expect(Fleet.basic_key).to be nil
      expect(Defence.basic_key).to be nil
    end

    it 'basic_name' do
      expect(DeuteriumRefinery.basic_name).to eq('Deuterium Refinery')
      expect(Cruiser.basic_name).to eq('Cruiser')
      expect(HeavyLaserCannon.basic_name).to eq('Heavy Laser Cannon')
      expect(Buildings.basic_name).to eq('Buildings')
      expect(Fleet.basic_name).to eq('Fleet')
      expect(Defence.basic_name).to eq('Defence')
    end

    it 'basic_description' do
      expect(CrystalMine.basic_description).to eq('Crystal Mine is a magical land where light reflects off multicolored crystals, creating a unique aura. This mining building, located in a valley among huge rock formations, specializes in obtaining crystals with unique energy properties. Mining is carried out using ancient technology, and each crystal seems to emanate a power that attracts researchers from all over the universe.')
      expect(HeavyFighter.basic_description).to eq("The Heavy Fighter is a powerful fighting machine, built for intense combat and battlefield domination. Armed with multi-barreled plasma cannons, long-range missiles and advanced defense systems, it is a formidable opponent for larger ships and groups of fighters. Although slower and less maneuverable than its lighter counterpart, it makes up for it with exceptional durability and firepower, able to withstand even the most ferocious attacks. Perfect for covering allies and breaking the enemy's defense line.")
      expect(HeavyIonCannon.basic_description).to eq('The Heavy Ion Cannon is the most powerful weapon of its type, designed for large-scale defensive missions. Thanks to extremely intense ion shots, it is able to destroy both spaceships and their energy systems. It is ideal for defending against large fleets, where eliminating multiple targets at the same time is crucial. Its advanced targeting systems guarantee high accuracy and effectiveness, and its powerful range makes it one of the most desirable weapons in the space defense arsenal.')
      expect(Buildings.basic_description).to be nil
      expect(Fleet.basic_description).to be nil
      expect(Defence.basic_description).to be nil
    end

    it 'basic_img' do
      expect(PowerStation.basic_img).to eq('buildings/power_station.png')
      expect(Warship.basic_img).to eq('fleet/warship.png')
      expect(RocketLauncher.basic_img).to eq('defence/rocket_launcher.png')
      expect(Buildings.basic_img).to be nil
      expect(Fleet.basic_img).to be nil
      expect(Defence.basic_img).to be nil
    end

    it 'default_relation_name' do
      expect(DeuteriumRefinery.default_relation_name).to eq('planet_building')
      expect(Cruiser.default_relation_name).to eq('planet_fleet')
      expect(HeavyLaserCannon.default_relation_name).to eq('planet_defence')
      expect(Buildings.default_relation_name).to eq('planet_building')
      expect(Fleet.default_relation_name).to eq('planet_fleet')
      expect(Defence.default_relation_name).to eq('planet_defence')
    end

    it 'default_source' do
      expect(DeuteriumRefinery.default_source).to be nil
      expect(Cruiser.default_source).to be nil
      expect(HeavyLaserCannon.default_source).to be nil
      expect(Buildings.default_source).to eq('buildings')
      expect(Fleet.default_source).to eq('fleet')
      expect(Defence.default_source).to eq('defence')
    end

    it 'class_order' do
      expect(PowerStation.class_order).to eq(4)
      expect(HeavyFighter.class_order).to eq(2)
      expect(LightLaserCannon.class_order).to eq(2)
      expect(Buildings.class_order).to be nil
      expect(Fleet.class_order).to be nil
      expect(Defence.class_order).to be nil
    end

    it 'subclasses' do
      expect(Buildings.subclasses('buildings')).to eq([MetalMine, CrystalMine, DeuteriumRefinery, PowerStation])
      expect(Fleet.subclasses('fleet')).to eq([LightFighter, HeavyFighter, Cruiser, Warship])
      expect(Defence.subclasses('defence')).to eq([RocketLauncher, LightLaserCannon, HeavyLaserCannon, LightIonCannon, HeavyIonCannon])

      expect(MetalMine.subclasses('buildings')).to eq([])
      expect(MetalMine.subclasses('fleet')).to eq([])
      expect(MetalMine.subclasses('defence')).to eq([])

      expect(LightFighter.subclasses('buildings')).to eq([])
      expect(LightFighter.subclasses('fleet')).to eq([])
      expect(LightFighter.subclasses('defence')).to eq([])

      expect(LightIonCannon.subclasses('buildings')).to eq([])
      expect(LightIonCannon.subclasses('fleet')).to eq([])
      expect(LightIonCannon.subclasses('defence')).to eq([])
    end
  end
end
