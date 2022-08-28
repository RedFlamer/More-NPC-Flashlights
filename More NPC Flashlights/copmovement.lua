Hooks:PostHook(CopMovement, "set_cool", "flashlight_set_cool", function(self, state)
	if self._ext_inventory:equipped_unit() then
		self._ext_inventory:equipped_unit():base():set_flashlight_enabled(not state) -- enable the flashlight when we become uncool, or disable if we become cool again
	end
end)
