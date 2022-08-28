-- probably not needed but better safe than sorry
local equip_selection_orig = PlayerInventory.equip_selection
function PlayerInventory:equip_selection(...)
	if equip_selection_orig(self, ...) then 
		if self._unit:movement().cool and self._unit:movement():cool() then
			self:equipped_unit():base():set_flashlight_enabled(false) -- disable the flashlight if we equip something while cool
		end

		return true
	end
end