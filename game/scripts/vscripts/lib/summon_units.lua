if SummonUnits == nil then
    SummonUnits = class({})
end

SummonUnits.radiant_spawn_entities = Entities:FindAllByName("radiant_spawn*")
SummonUnits.dire_spawn_entities = Entities:FindAllByName("dire_spawn*")

function SummonUnits:CleanAllUnits()
    local all_units = FindUnitsInRadius(DOTA_TEAM_GOODGUYS, Vector(0,0,0), nil, 4000,DOTA_UNIT_TARGET_TEAM_BOTH,DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, 0, false)
    for _,unit in pairs(all_units) do
        if unit:IsHero() ~= true then
            unit:RemoveSelf()
        end
    end
end

function SummonUnits:SpawnUnits()
    self.radiant_spawn_entities = Entities:FindAllByName("radiant_spawn*")
    self.dire_spawn_entities = Entities:FindAllByName("dire_spawn*")
    local radiant_player_id = 0
    local dire_player_id  = 1
    local radiant_player = PlayerResource:GetPlayer(0)
    local dire_player = PlayerResource:GetPlayer(1)
    if radiant_player ~= nil then 
        for _,entity in pairs(self.radiant_spawn_entities) do
            local creep = CreateUnitByName("npc_arena_unit_ancient_apparition",entity:GetAbsOrigin(),true, radiant_player,radiant_player,DOTA_TEAM_GOODGUYS)
            creep:SetControllableByPlayer(radiant_player_id, false)
			creep:SetForwardVector(Vector(1,0,0))
        end
    end

    if dire_player ~= nil then
        for _,entity in pairs(self.dire_spawn_entities) do
            CreateUnitByName("npc_dota_creature_gnoll_assassin",entity:GetAbsOrigin(),true, dire_player,radiant_player,DOTA_TEAM_BADGUYS)
        end
    end

end
