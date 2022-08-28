Hooks:PostHook(NewNPCRaycastWeaponBase, "init", "flashlight_init", function(self)
	if not self._flashlight_data and self._unit:get_object(Idstring("a_effect_flashlight")) then
		local effect = self._unit:effect_spawner(Idstring("flashlight"))
		if not effect then return end -- effect failed to spawn for whatever reason, most likely the object is missing the effect spawner

		local light = World:create_light("spot|specular")
		local light_object = self._unit:get_object(Idstring("a_effect_flashlight"))

		self._light = light
		self._flashlight_data = {
			light = light,
			effect = effect
		}
		light:set_far_range(400)
		light:set_spot_angle_end(25)
		light:set_multiplier(2)
		light:link(light_object)
		light:set_rotation(Rotation(light_object:rotation():z(), -light_object:rotation():x(), -light_object:rotation():y()))
		light:set_enable(false)
	end
end)

Hooks:PostHook(NewNPCRaycastWeaponBase, "destroy", "flashlight_destroy", function(self)
	if alive(self._light) then
		World:delete_light(self._light)
		self._flashlight_data = nil
	end
end)