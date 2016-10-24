////////////////////////////////////////////Chlorine + Phosgene (a.k.a. Blue Cross)//////////////////////////////////////////
/obj/effect/particle_effect/smoke/gas
	lifetime = 35
	icon = 'icons/effects/warsmoke.dmi'
	icon_state = "gas"
	pixel_x = -32
	pixel_y = -32

/obj/effect/particle_effect/smoke/gas/smoke_mob(mob/living/carbon/human/M)
	//if (!..()) // I think that's unnecessary.
	//	return 0
	//M.drop_item()   //Was this really needed?..
	if (!M.wear_suit || !M.w_uniform || !M.gloves)
		M.adjustFireLoss(20)
	if (!M.wear_mask && !istype(M.wear_mask, /obj/item/clothing/mask/gas))
		M.blur_eyes(20)
		M.adjust_eye_damage(5)
		M.adjustOxyLoss(10)
		M << "<span class='userdanger'>Your eyes, your chest... it hurts so much!</span>"
		M.emote(pick("gasp", "cough"))
/*		if (M.phosgene_affected != 1)
			var/datum/disease/phosgene/PH
			M.phosgene_affected = 1
			M.contract_disease(new PH, 1)*/