/*
*	IMPROVISED RIFLE
*	There was an improvised rifle on Cit/Skyrat, it's pretty cool so here it is too.
*	We're using a slightly modified sprite designed around a Short Magazine Lee Enfield (SMLE) Mk.III
*/

/obj/item/ammo_box/magazine/internal/boltaction/improvised
	max_ammo = 1
	multiload = 0

/obj/item/gun/ballistic/rifle/irifle
	name = "improvised 7.62 rifle"
	desc = "An improvised rifle that fires hard-hitting 7.62 bullets."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "irifle"
	inhand_icon_state = "irifle"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	bolt_type = BOLT_TYPE_LOCKING
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/improvised
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	pixel_x = -8
	weapon_weight = WEAPON_HEAVY	// It's big.

/*
*	IMPROVISED SHOTGUN
*	We're using the rifle because we want the bolt action so we can pretend it's a break action gun.
*	On Skyrat/Cit there was a need to tone improvised weapons down due to their incredible ease of access.
*	This is the same nerf, but drastically more fun. We now need two hands to fire and we have a slightly slower action.
*/

/obj/item/gun/ballistic/rifle/ishotgun
	name = "improvised shotgun"
	desc = "A break-action 12 gauge shotgun. You need both hands to fire this."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "ishotgun"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	pixel_x = -8
	inhand_icon_state = "ishotgun"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	slot_flags = null
	bolt_type = BOLT_TYPE_LOCKING
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	sawn_desc = "A break-action 12 gauge shotgun, but with most of the stock and some of the barrel removed. You still need both hands to fire this."
	unique_reskin = null
	var/slung = FALSE
	weapon_weight = WEAPON_HEAVY	// It's big.
	recoil = 4	// We're firing 12 gauge.
	can_be_sawn_off = TRUE
	bolt_wording = "barrel"

/obj/item/ammo_box/magazine/internal/shot/improvised
	name = "improvised shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/improvised
	max_ammo = 1

/obj/item/gun/ballistic/rifle/ishotgun/examine(mob/user)
	. = ..()
	. += "The barrel is [bolt_locked ? "broke open" : "closed"]."

/obj/item/gun/ballistic/rifle/ishotgun/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		var/obj/item/stack/cable_coil/C = A
		if(C.use(10))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, span_notice("You tie the lengths of cable to the shotgun, making a sling."))
			slung = TRUE
			update_icon()
		else
			to_chat(user, span_warning("You need at least ten lengths of cable if you want to make a sling!"))

/obj/item/gun/ballistic/rifle/ishotgun/update_icon_state()
	. = ..()
	if(slung)
		inhand_icon_state = "ishotgunsling"
	if(sawn_off)
		inhand_icon_state = "ishotgun_sawn"

/obj/item/gun/ballistic/rifle/ishotgun/update_overlays()
	. = ..()
	if(slung)
		. += "ishotgunsling"
	if(sawn_off)
		. += "ishotgun_sawn"

/obj/item/gun/ballistic/rifle/ishotgun/sawoff(mob/user, obj/item/saw, handle_modifications = FALSE)
	. = ..()
	if(!.)
		return
	if(. && slung) //sawing off the gun removes the sling
		new /obj/item/stack/cable_coil(get_turf(src), 10)
		slung = 0
		update_icon()
	name = "sawn-off [src.name]"
	desc = sawn_desc
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags |= ITEM_SLOT_BELT
	recoil = SAWN_OFF_RECOIL
	update_appearance()
	return TRUE

/obj/item/gun/ballistic/rifle/ishotgun/sawn
	name = "sawn-off improvised shotgun"
	desc = "A break-action 12 gauge shotgun, but with most of the stock and some of the barrel removed. You still need both hands to fire this."
	w_class = WEIGHT_CLASS_NORMAL
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT

/*
*	CFA RIFLE
*/

/obj/item/gun/ballistic/automatic/cfa_rifle
	name = "Cantanheim 6.8mm rifle"
	desc = "A simple semi-automatic rifle chambered in 6.8mm. The letters 'XJP' are crossed out in the receiver." //Different 6.8mm than the FTU's propietary pulse ballistics
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "cfa_rifle"
	inhand_icon_state = "irifle"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	worn_icon_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/cm68
	fire_delay = 5
	can_suppress = FALSE
	burst_size = 0
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	mag_display = FALSE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	recoil = 1
	weapon_weight = WEAPON_HEAVY
	pixel_x = -8
	has_gun_safety = FALSE
	w_class = WEIGHT_CLASS_BULKY
	company_flag = COMPANY_CANTALAN

/obj/item/gun/ballistic/automatic/cfa_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/cfa_rifle/empty
	spawnwithmagazine = FALSE

/obj/item/ammo_box/magazine/cm68
	name = "rifle magazine (6.8mm)"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "6.8"
	ammo_type = /obj/item/ammo_casing/a68
	caliber = CALIBER_A68
	max_ammo = 10
	multiple_sprites = 2

/obj/item/ammo_box/magazine/cm68/empty
	start_empty = 1
