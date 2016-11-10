/obj/item/clothing/suit/armor/strapvest
	name = "strap vest"
	desc = "A cloth strap vest for storing ammunition, grenades, and other equipment."
	icon_state = "germvest"
	item_state = "germvest"
	blood_overlay_type = "armor"
	armor = list(melee = 5, bullet = 5, laser = 0, energy = 0, bomb = 5, bio = 0, rad = 0, fire = 0, acid = 0)
	pockets = /obj/item/weapon/storage/internal/pocket/vest

/obj/item/clothing/suit/armor/strapvest/german
	name = "german vest"

/obj/item/clothing/suit/armor/strapvest/french
	name = "french vest"
	desc = "A cloth strap vest for storing ammunition, grenades, and other equipment."
	icon_state = "frenchvest"
	item_state = "frenchvest"

/obj/item/clothing/suit/armor/strapvest/british
	name = "british vest"
	desc = "A cloth strap vest for storing ammunition, grenades, and other equipment."
	icon_state = "britvest"
	item_state = "britvest"

/obj/item/clothing/suit/armor/trench
	name = "trenchcoat"
	desc = "A warm trenchcoat to make sure you'll die from a bullet wound and not hypothermia."
	icon_state = "germtrench"
	item_state = "germtrench"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list(melee = 10, bullet = 15, laser = 0, energy = 0, bomb = 10, bio = 0, rad = 0, fire = 5, acid = 5)
	pockets = /obj/item/weapon/storage/internal/pocket

/obj/item/clothing/suit/armor/trench/german
	name = "german trenchcoat"

/obj/item/clothing/suit/armor/trench/german/medic
	name = "german medic trenchcoat"
	icon_state = "medgermtrench"
	item_state = "medgermtrench"

/obj/item/clothing/suit/armor/trench/french
	name = "french trenchcoat"
	icon_state = "frenchtrench"
	item_state = "frenchtrench"

/obj/item/clothing/suit/armor/trench/french/medic
	name = "french medic trenchcoat"
	icon_state = "medfrenchtrench"
	item_state = "medfrenchtrench"

/obj/item/clothing/suit/armor/trench/brit
	name = "british jacket"
	desc = "A cozy jacket. It'll still look good 100 years from now."
	icon_state = "britsuit"
	item_state = "britsuit"

/obj/item/clothing/suit/armor/trench/german/medic
	name = "british medic jacket"
	icon_state = "medbritsuit"
	item_state = "medbritsuit"