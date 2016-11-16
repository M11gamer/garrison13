////////////////////////////////////////////Chlorine + Phosgene (a.k.a. Blue Cross)//////////////////////////////////////////
/obj/effect/effect/smoke/gas
	time_to_live = 500 // Modifies gas lifetime. The final result will always be slightly random.
	icon = 'icons/effects/warsmoke.dmi'
	icon_state = "gas"
	pixel_x = -32
	pixel_y = -32

/obj/effect/effect/smoke/gas/Move()
	..()
	for(var/mob/living/carbon/human/M in get_turf(src))
		affect(M)

/obj/effect/effect/smoke/gas/affect(var/mob/living/carbon/human/M)
	//if (!..()) // I think that's unnecessary.
	//	return 0
	//M.drop_item()   //Was this really needed?..
	if (!M.wear_suit || !M.w_uniform || !M.gloves)
		M.burn_skin(0.1)
		//M.adjustFireLoss(1) // If simple skin burning is not enough

	if (!M.wear_mask && !istype(M.wear_mask, /obj/item/clothing/mask/gas))
		var/obj/item/organ/eyes/eyes = M.internal_organs_by_name["eyes"]
		M.burn_skin(0.5)
		eyes.take_damage(rand(1, 3))
		M << "\red Your eyes sting and burn!"
		M.adjustOxyLoss(10)
		if (prob(25))
			M.rupture_lung()
			M << "\red Your chest hurts HORRIFICALLY!"
		if (M.coughedtime != 1)
			M.coughedtime = 1
			M << "\red Your chest hurts."
			M.emote(pick("gasp", "cough"))
			spawn ( 20 )
				M.coughedtime = 0
/*		if (M.phosgene_affected != 1)
			var/datum/disease/phosgene/PH
			M.phosgene_affected = 1
			M.contract_disease(new PH, 1)*/
		M.updatehealth()