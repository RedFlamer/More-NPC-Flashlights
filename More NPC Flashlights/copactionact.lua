local _play_anim_orig = CopActionAct._play_anim
function CopActionAct:_play_anim(...)
	-- act actions disable the flashlight if needs to be done from idle, which generally means specialobjectives
	if _play_anim_orig(self, ...) then
		if self._action_desc.needs_full_blend and self._unit:inventory():equipped_unit() then
			self._unit:inventory():equipped_unit():base():set_flashlight_enabled(false)
			self._flashlight_disabled = true
		end
		
		return true
	end
end

Hooks:PostHook(CopActionAct, "on_exit", "flashlight_on_exit", function(self)
	if self._flashlight_disabled and self._unit:inventory():equipped_unit() and not self._unit:movement():cool() then
		self._unit:inventory():equipped_unit():base():set_flashlight_enabled(true)
	end
end)