require("lib/timers")


function BlackHole( keys )
    local point = keys.target_points[1]
    local caster = keys.caster
    local ability = keys.ability
    local targets =  FindUnitsInRadius(caster:GetTeamNumber(), point , nil, 300, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
    ability.point = point
    
    --effect
    local black_hole = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/enigma_blackhole.vpcf", PATTACH_ABSORIGIN, caster)
    ability.black_hole_effect = black_hole
    ParticleManager:SetParticleControl(black_hole, 0, point)

    --modifier
    for _target in pairs( targets) do
        ability:ApplyDataDrivenModifier(caster, target, "modifier_black_hole_debuff", {})
    end
end

function BlackHole_motion( keys )
    --DeepPrintTable(keys)
    local ability = keys.ability
    local caster = keys.caster
    local point = ability.point
    local targets =  FindUnitsInRadius(caster:GetTeamNumber(), point , nil, 300, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
    local total_distance = 200
    local step = total_distance / (30 * 4)
    for _,target in pairs(targets) do
        local new_posi = target:GetAbsOrigin() + (point - target:GetAbsOrigin()):Normalized() * step    
        target:SetAbsOrigin(new_posi)
    end
end

function TestUnit( keys )
	local caster = keys.caster
	local target_point = keys.target_points[1]
	CreateUnitByName("npc_dota_creature_gnoll_assassin", target_point, true, nil, nil, 3) 
end

function BlackHole_stop( keys )
    local caster = keys.caster
    local ability = keys.ability
    local point = ability.point
    ParticleManager:DestroyParticle(ability.black_hole_effect, false)
    local targets =  FindUnitsInRadius(caster:GetTeamNumber(), point , nil, 300, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
    for _,target in pairs(targets) do 
        target:InterruptMotionControllers(true)
        target:RemoveModifierByName("modifier_black_hole_debuff")
    end
    StopSoundOn("Hero_Enigma.Black_Hole", caster)
end


function Fissure( keys )
    local caster = keys.caster
    local point = keys.target_points[1]
    local target_point = caster:GetAbsOrigin() + (point-caster:GetAbsOrigin()):Normalized()* 800
    local ability = keys.ability
    ability.target_point = target_point
    ability.start_point = caster:GetAbsOrigin()
    --effect
    local fissure = ParticleManager:CreateParticle("particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(fissure, 1, target_point)
    ParticleManager:SetParticleControl(fissure, 2, Vector(5,0,0))
end

function Fissure_move_units( keys )
    local caster = keys.caster
    local point = keys.target_points[1]
    local ability = keys.ability
    local target_point = ability.target_point
    local width = 100
    


    local units = FindUnitsInLine(caster:GetTeamNumber(), caster:GetAbsOrigin(), target_point, nil, width, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0)
    for _,unit in pairs(units) do
        if unit ~= caster then
            local u_vector = unit:GetAbsOrigin() - caster:GetAbsOrigin()
            local length = u_vector:Dot((target_point-caster:GetAbsOrigin()):Normalized())
            local orthogonal_point = caster:GetAbsOrigin() + (target_point-caster:GetAbsOrigin()):Normalized()*length
            local parallel_distance = (unit:GetAbsOrigin() - orthogonal_point):Length2D()
            local new_point = unit:GetAbsOrigin() + (unit:GetAbsOrigin() - orthogonal_point):Normalized() * (width - parallel_distance)
            unit:SetAbsOrigin(new_point)
        end
    end
end

function Fissure_block( keys )
    local ability = keys.ability
    local target_point = ability.target_point
    local target = keys.unit
    local caster = keys.caster
    local start_point = ability.start_point
    local u_vector = target:GetAbsOrigin() - start_point
    local length = u_vector:Dot((target_point- start_point):Normalized())
    local orthogonal_point = start_point + (target_point - start_point):Normalized()*length
    local parallel_distance = (target:GetAbsOrigin() - orthogonal_point):Length2D()
    local normal_vec = target:GetAbsOrigin() - orthogonal_point
    if parallel_distance < 80 and normal_vec:Dot(target:GetForwardVector()) < 0 then
        ability:ApplyDataDrivenModifier(caster, target, "modifier_fissure_block", {})
    else
        target:RemoveModifierByName("modifier_fissure_block")
    end

    local tip_dis_target = (target_point - target:GetAbsOrigin()):Length2D()
    local tip_dis_start = (start_point - target:GetAbsOrigin()):Length2D()

    if tip_dis_target < 80 and target:GetForwardVector():Dot(start_point-target_point) > 0 then
        ability:ApplyDataDrivenModifier(caster, target, "modifier_fissure_block", {})
    end

    if tip_dis_start < 80 and target:GetForwardVector():Dot(target_point - start_point) > 0 then
        ability:ApplyDataDrivenModifier(caster, target, "modifier_fissure_block", {})
    end


end

function Fissure_clean( keys )
    local ability = keys.ability
    local caster = keys.caster
    local start_point = ability.start_point
    local targets = FindUnitsInRadius(caster:GetTeamNumber(), start_point , nil, 1000, DOTA_UNIT_TARGET_TEAM_BOTH, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)	
    for _,unit in pairs(targets) do
        unit:RemoveModifierByName("modifier_fissure_target")
        unit:RemoveModifierByName("modifier_fissure_block")
       --[[Timers:CreateTimer(0.2, function()
            print("remove")
            unit:RemoveModifierByName("modifier_fissure_block")
            unit:RemoveModifierByName("modifier_fissure_block")
            return nil
        end
        ) ]]--  

    end
end

function Aphotic_Shield(keys)
    local ability = keys.ability
    local caster = keys.caster
    local target = keys.target

    local shield = ParticleManager:CreateParticle("Particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf",PATTACH_ABSORIGIN,target)
    ParticleManager:SetParticleControlEnt( shield, 0 , target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
    ParticleManager:SetParticleControl(shield, 1, Vector(80,0,0))
    target.shield = shield
end

function Aphotic_Shield_Destroy(keys)
    local target = keys.target
    ParticleManager:DestroyParticle(target.shield, false)
    StopSoundOn("Hero_Abaddon.AphoticShield.Loop", target)
end

function Ice_Vortex( keys )
    local point = keys.target_points[1]
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    local ability = keys.ability
    local dummy = CreateUnitByName("dummy_aa_slow", point, false, player, player, caster:GetTeamNumber())
    dummy:AddNewModifier(caster, ability, "modifier_kill", {duration = 5})
    dummy:AddNoDraw()

    --effect
    local vortex = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_ice_vortex.vpcf",PATTACH_WORLDORIGIN,nil)
    ParticleManager:SetParticleControl(vortex, 0, dummy:GetAbsOrigin())
    ParticleManager:SetParticleControl(vortex, 5, Vector(300,0,0))

    ability.vortex = vortex
end

function Ice_Vortex_destroy( keys )
    local ability = keys.ability
    print(ability.vortex)
    ParticleManager:DestroyParticle(ability.vortex, false)

end

function Ice_Vortex_stop_sound(keys)
    local caster = keys.caster
    StopSoundOn("Hero_Ancient_Apparition.IceVortex", caster)
end

function Global_Silence( keys )
    local ability = keys.ability 
    local caster = keys.caster
    local targets = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin() , nil, 3000, DOTA_UNIT_TARGET_TEAM_ENEMY, ability:GetAbilityTargetType(), ability:GetAbilityTargetFlags(), 0, false)
    for _,unit in pairs(targets) do
        ability:ApplyDataDrivenModifier(caster, unit, "modifier_global_silence_target", {})
    end

    --effect
    local silence = ParticleManager:CreateParticle("particles/units/heroes/hero_silencer/silencer_global_silence.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControlEnt( silence, 1 , caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetOrigin(), true )

end

function Global_Silence_Destroy( keys )
    local ability = keys.ability
    local target = keys.target
    targer:StopSound("Hero_Silencer.GlobalSilence.Effect")
end

function Teleport_Start( keys )
    local caster = keys.caster
    local point = keys.target_points[1]
    local ability = keys.ability
    ability.teleport_effect_end = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_teleport_end.vpcf", PATTACH_WORLDORIGIN, nil)
    ability.teleport_effect_start = ParticleManager:CreateParticle("particles/units/heroes/hero_furion/furion_teleport.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(ability.teleport_effect_end, 1, point)
    
end

function Teleport_cast_success( keys )
    local caster = keys.caster
    local ability = keys.ability
    ParticleManager:SetParticleControl(ability.teleport_effect_start, 2, Vector(50,0,0))
    ParticleManager:SetParticleControl(ability.teleport_effect_end, 2, Vector(50,0,0))
    ParticleManager:DestroyParticle(ability.teleport_effect_end, false)
    ParticleManager:DestroyParticle(ability.teleport_effect_start,false)
    caster:AddNoDraw()
    caster:SetAbsOrigin(keys.target_points[1])
    caster:RemoveNoDraw()
end

function Teleport_cast_failure( keys )
    local caster = keys.caster
    local ability = keys.ability
    ParticleManager:SetParticleControl(ability.teleport_effect_start, 2, Vector(0,0,0))
    ParticleManager:SetParticleControl(ability.teleport_effect_end, 2, Vector(0,0,0))
    ParticleManager:DestroyParticle(ability.teleport_effect_end, false)
    ParticleManager:DestroyParticle(ability.teleport_effect_start,false)
end

function Missile_cast( keys )
    local caster = keys.caster
    local ability = keys.ability
    local target = keys.target
    local player = caster:GetPlayerOwner()
    local missile = CreateUnitByName("Missile", caster:GetAbsOrigin()+caster:GetForwardVector()*150, true, player, player, caster:GetTeamNumber()) 
    ability.missile = missile
    ability.target = keys.target
    print(missile,"mis")
    missile:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 4/5)
    Timers:CreateTimer(2.3,function()
        ability:ApplyDataDrivenModifier(caster, missile, "modifier_missile_dummy", {})
        --missile:StartGesture(ACT_DOTA_RUN)
        
        return nil
    end)

    --effect
    local spark = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_guided_missile.vpcf", PATTACH_ABSORIGIN,missile)
    ParticleManager:SetParticleControlEnt( spark, 0 , missile, PATTACH_POINT_FOLLOW, "attach_fuse", missile:GetOrigin(), true )

end

function Missile_Check( keys )
    local ability = keys.ability
    local missile = ability.missile
    local caster = keys.caster
    local target = ability.target 
    
    if not missile:IsNull() then
        missile:SetForwardVector(target:GetAbsOrigin() - missile:GetAbsOrigin())
        missile:SetAbsOrigin(missile:GetAbsOrigin() + missile:GetForwardVector():Normalized()* 10)
        if (target:GetAbsOrigin() - missile:GetAbsOrigin()):Length2D() < 30 then
            local explo = ParticleManager:CreateParticle("particles/econ/items/gyrocopter/hero_gyrocopter_gyrotechnics/gyro_guided_missile_explosion.vpcf",PATTACH_WORLDORIGIN,nil)
            ParticleManager:SetParticleControl(explo, 0, missile:GetAbsOrigin())
            ability:ApplyDataDrivenModifier(caster, target, "modifier_missile_stun", {})
            local damageTable = {victim=target,
                        attacker=caster,
                        damage=100,    
                        damage_type=DAMAGE_TYPE_MAGICAL} 
            ApplyDamage(damageTable)
            EmitSoundOn("Hero_Gyrocopter.HomingMissile.Target", target)
            EmitSoundOn("Hero_Gyrocopter.HomingMissile.Destroy", target)
            StopSoundOn("Hero_Gyrocopter.HomingMissile.Enemy", caster)
            missile:RemoveModifierByName("modifier_missile_dummy")
            missile:RemoveSelf()
        end
    end 
end

function Sacred_Arrow( keys )
    local caster = keys.caster
    local point = keys.target_points[1]
    local ability = keys.ability
    ability.start_point = caster:GetAbsOrigin()
    local projectile_table = {
		Ability = keys.ability,
		Source = keys.caster,
		EffectName = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf",
		vSpawnOrigin = keys.caster:GetAbsOrigin(),
		vVelocity = (point-caster:GetAbsOrigin()):Normalized()*800,
		fDistance = 2000,
		fStartRadius = 50, --divide by 2?
		fEndRadius = 50, --divide by 2?
		bHasFrontalCone = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_ALL,
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(projectile_table)

end


function Sacred_Arrow_stun( keys )
    local point = keys.ability.start_point
    local caster = keys.caster
    local ability = keys.ability
    local target = keys.target
    local fly_distance = (point - target:GetAbsOrigin()):Length2D()
    local duration = fly_distance/2000 * 5
    target:AddNewModifier(caster, ability, "modifier_stunned", {duration = duration})
end

function Blink( keys )
    local caster = keys.caster
    local point = keys.target_points[1]
    if (point-caster:GetAbsOrigin()):Length2D() > 1050 then
        point = caster:GetAbsOrigin() + (point-caster:GetAbsOrigin()):Normalized() * 1050
    end

    local blink = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControlForward(blink, 0, caster:GetForwardVector())

    caster:SetAbsOrigin(point)

    local blink = ParticleManager:CreateParticle("particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControlForward(blink, 0, point)
end

function X_Mark( keys )
    local ability = keys.ability
    local caster = keys.caster
    local target = keys.target
    ability.original_point = target:GetAbsOrigin()
    --local mark = ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_x_spot_fxset.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    --target.x_mark = mark
    ability:ApplyDataDrivenModifier(caster, target, "modifier_x_mark", {})
end

function X_Mark_return( keys )
    local ability = keys.ability
    local original_point = ability.original_point
    local target = keys.target
    target:SetAbsOrigin(original_point)
    target:StopSound("Ability.XMark.Target_Movement")
end