require("lib/timers")
require("lib/summon_units")

if ArenaGameMode == nil then
	ArenaGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	PrecacheResource( "particle", "particles/units/heroes/hero_crystalmaiden/maiden_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_batrider/batrider_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_morphling/morphling_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_templar_assassin/templar_assassin_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_tinker/tinker_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/neutral_fx/gnoll_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_brewmaster/brewmaster_hurl_boulder.vpcf", context )  
        PrecacheResource( "particle", "particles/neutral_fx/ghost_frost_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_sniper/sniper_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_visage/visage_familiar_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_base_attack.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_dragon_knight/dragon_knight_elder_dragon_fire.vpcf", context )  
        PrecacheResource( "particle", "particles/skills/arrow_of_light/arrow_of_light.vpcf", context )  
        PrecacheResource( "particle", "particles/units/heroes/hero_rubick/rubick_base_attack.vpcf", context )
        PrecacheResource( "particle", "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf", context )
        
        
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pudge", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_items.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rattletrap.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_obsidian_destroyer.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_creeps.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skeletonking.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )        
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )  
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context )   
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context ) 
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context ) 
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pugna.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/fast_freeze.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/mana_void_modified.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/magic_well_cast.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rubick.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_puck.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_mirana.vsndevts", context )
        PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_kunkka.vsndevts", context )
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = ArenaGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function ArenaGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	GameRules:GetGameModeEntity():SetCameraDistanceOverride(1800)
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)

	CustomGameEventManager:RegisterListener("cast_special_ability",Dynamic_Wrap(ArenaGameMode,'OnCastSpecialAbility'))
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(ArenaGameMode,"OnGameRulesStateChange"), self)--listen to game state
        GameRules:GetGameModeEntity():SetDamageFilter( Dynamic_Wrap(ArenaGameMode, "Damagefilter_main" ), self )
	
end

-- Evaluate the state of the game
function ArenaGameMode:OnThink()
	
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then

	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

function ArenaGameMode:OnGameRulesStateChange( keys )
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_PRE_GAME then
		PlayerResource:SetCameraTarget(0, Entities:FindByClassname(nil, "world_bounds"))
	elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		SummonUnits:CleanAllUnits()
		SummonUnits:SpawnUnits()
	end
end
	
function ArenaGameMode:OnCastSpecialAbility( keys )
	local unit = EntIndexToHScript(keys.Selected_Unit["0"])
	local ability = unit:GetAbilityByIndex(0)
	print()
	ability:CastAbility()
end

function ArenaGameMode:Damagefilter_main( filterTable)
        if ArenaGameMode:Damagefilter_abaddon_shield(filterTable) then
                return true
        else
                return false
        end
end

function ArenaGameMode:Damagefilter_abaddon_shield(filterTable)
        local attackerIndex = filterTable["entindex_attacker_const"]
	local victimIndex = filterTable["entindex_victim_const"]
        local attacker = EntIndexToHScript(attackerIndex)
        local victim = EntIndexToHScript(victimIndex)
        local damage = filterTable["damage"]
        if victim:HasModifier("modifier_aphotic_shield_owner") then
                victim:RemoveModifierByName("modifier_aphotic_shield_owner")
                return false
        end

        return true
end