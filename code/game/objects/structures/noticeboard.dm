/obj/structure/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "nboard00"
	density = 0
	anchored = 1
	obj_integrity = 150
	max_integrity = 150
	var/notices = 0

/obj/structure/noticeboard/initialize()
	for(var/obj/item/I in loc)
		if(notices > 4) break
		if(istype(I, /obj/item/weapon/paper))
			I.loc = src
			notices++
	icon_state = "nboard0[notices]"

//attaching papers!!
/obj/structure/noticeboard/attackby(obj/item/weapon/O, mob/user, params)
	if(istype(O, /obj/item/weapon/paper))
		if(notices < 5)
			if(!user.drop_item())
				return
			O.add_fingerprint(user)
			add_fingerprint(user)
			O.loc = src
			notices++
			icon_state = "nboard0[notices]"	//update sprite
			user << "<span class='notice'>You pin the paper to the noticeboard.</span>"
		else
			user << "<span class='notice'>You reach to pin your paper to the board but hesitate. You are certain your paper will not be seen among the many others already attached.</span>"
	else
		return ..()

/obj/structure/noticeboard/attack_hand(mob/user)
	var/dat = "<B>Noticeboard</B><BR>"
	for(var/obj/item/weapon/paper/P in src)
		dat += "<A href='?src=\ref[src];read=\ref[P]'>[P.name]</A> <A href='?src=\ref[src];write=\ref[P]'>Write</A> <A href='?src=\ref[src];remove=\ref[P]'>Remove</A><BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=noticeboard")
	onclose(user, "noticeboard")


/obj/structure/noticeboard/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if((usr.stat || usr.restrained()))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["remove"])
		if((P && P.loc == src))
			P.loc = get_turf(src)	//dump paper on the floor because you're a clumsy fuck
			P.add_fingerprint(usr)
			add_fingerprint(usr)
			notices--
			icon_state = "nboard0[notices]"

	if(href_list["write"])
		if((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"])

		if((P && P.loc == src)) //ifthe paper's on the board
			var/obj/item/I = usr.is_holding_item_of_type(/obj/item/weapon/pen)
			if(I) //check hand for pen
				add_fingerprint(usr)
				P.attackby(I, usr)
			else
				usr << "<span class='notice'>You'll need something to write with!</span>"

	if(href_list["read"])
		var/obj/item/weapon/paper/P = locate(href_list["read"])
		if((P && P.loc == src))
			if(!ishuman(usr))
				usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY><TT>[stars(P.info)]</TT></BODY></HTML>", "window=[P.name]")
				onclose(usr, "[P.name]")
			else
				usr << browse("<HTML><HEAD><TITLE>[P.name]</TITLE></HEAD><BODY><TT>[P.info]</TT></BODY></HTML>", "window=[P.name]")
				onclose(usr, "[P.name]")

/obj/structure/noticeboard/deconstruct(disassembled = TRUE)
	if(!(flags & NODECONSTRUCT))
		new /obj/item/stack/sheet/metal (loc, 1)
	qdel(src)
