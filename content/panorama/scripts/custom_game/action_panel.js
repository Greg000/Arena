"use strict"

AutoUpdateAbility();

function CastSpecialAbility(){
    var pID = Game.GetLocalPlayerID()
    var SelectedUnit = Players.GetSelectedEntities(pID)
    var ability = Entities.GetAbility(SelectedUnit[0],0)
    Abilities.ExecuteAbility( ability, SelectedUnit[0], false )
    
    /**GameEvents.SendCustomGameEventToServer("cast_special_ability",{ "Selected_Unit" : SelectedUnit,"player_id" : pID});*/
}

function a(){

}



function AutoUpdateAbility()
{
	UpdateAbility()
	$.Schedule( 0.1, AutoUpdateAbility );
}

function UpdateAbility(){
    var pID = Game.GetLocalPlayerID()
    var SelectedUnit = Players.GetSelectedEntities(pID)[0]
    var ability = Entities.GetAbility(SelectedUnit, 0)
    var ability_name = Abilities.GetAbilityName(ability)

    $( "#AbilityImage" ).abilityname = ability_name;
}