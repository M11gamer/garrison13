/obj/structure/telegraph
	name = "telegraph machine"
	desc = "Text messaging, 1843 style."
	icon = 'icons/obj/objects.dmi'
	icon_state = "dispenser"
	density = 1
	anchored = 1
	var/cooldown = 0
	var/ID = 0
	var/list/obj/structure/telegraph/connected

/obj/item/weapon/telegraphcable
	name = "telegraph cable"
	desc = "A coil of telegraph cable, used to connect a telegraph machine with another."
	icon = 'icons/obj/items.dmi'
	icon_state = "telegraphcable"
	w_class = 2
	slot_flags = SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined", "flogged")
	var/obj/structure/telegraph/plugged

/obj/structure/telegraph/New()
	if(!ID)
		return
	for(var/obj/structure/telegraph/T in world)
		if(T.ID == ID)
			T.connected += src
			connected += T

/obj/structure/telegraph/attackby(obj/item/W, mob/living/user, params)
	if(istype(W,/obj/item/weapon/telegraphcable))
		var/obj/item/weapon/telegraphcable/C = W
		var/obj/structure/telegraph/hooked = C.plugged
		if(hooked in connected || src in hooked.connected || src == hooked)
			return
		if(!hooked)
			hooked = src
			user << "<span class='notice'>You connect one end of [C] to [src].</span>"
		if(user.drop_item(C))
			hooked.connected += src
			connected += hooked
			user << "<span class='notice'>You connect [src] with the other end of [C]. The telegraphs are now hooked up and will transmit to each other.</span>"
			qdel(C)

/obj/structure/telegraph/attack_hand(mob/living/user)
	if(cooldown)
		user << "<span class='warning'>This machinery is still cooling down. Do you know how much heat this intricate assembly produces?</span>"
		return
	var/t = sanitize(input(user, "What do you wish to transmit?", "Telegram"), MAX_NAME_LEN)
	if(!t)
		return
	if(!Adjacent(user))
		return
	user << "<span class='notice'>Message transmitted.</span>"
	for(var/obj/structure/telegraph/receiver in connected)
		receiver.audible_message("[receiver] transmits, \"[t]\"</span>")
	cooldown = 1
	spawn(300)
		cooldown = 0