extends Node

class_name GameplayController

@onready var vn_controller: VNController = $VNController
@export var placeholder_background_investigation_location: String = "res://assets/locations/placeholder_background_investigation/placeholder_background_investigation_location.tscn"
var clicked: ClickableRoot = null

func _init() -> void:
	Engine.register_singleton(&"GameplayController", self)


func _ready() -> void:
	await _act_1()
	await _act_2()

func _act_1() -> void:
	# characters
	var alice:= vn_controller.load_character("res://assets/characters/alice/alice.tscn")
	var davian:= vn_controller.load_character("res://assets/characters/davian/davian.tscn")
	var protagonist:= vn_controller.load_character("res://assets/characters/protagonist/protagonist.tscn")
	# locations
	var black:= "res://assets/locations/black/black.tscn"
	var venue:= "res://assets/locations/venue/venue.tscn"
	var backstage:= "res://assets/locations/backstage/backstage.tscn"
	var reveal := "res://assets/locations/reveal/reveal.tscn"
	var empty_podium := "res://assets/locations/empty_podium/empty_podium.tscn"

	await vn_controller.set_location(black, 0.0)

	await vn_controller.show_texts([
		"The opening day.",
		"Such a chaotic day for the staff.",
		"But it’s worth it."
		])

	await vn_controller.set_location(venue, 1.0)

	await vn_controller.show_texts([
		"This ain’t my first rodeo as a furry conference volunteer, but it’s my first one here.",
		"Wanted to help my friend Boris on the organizing team, ended up being dragged here at the same time he had to step out for family reasons. At least my room was covered."
		])

	await vn_controller.set_location(backstage, 1.0)
	
	await vn_controller.show_texts([
		"In just a couple hours, the opening ceremony will take place on the stage. Hundreds of furries from many different places coming together to have a good weekend.",
		"That’s one of the reasons why i do this. You don’t get much recognition, but it’s nice seeing everyone smile and laugh, just like in my first cons.",
		"In the meantime, gotta make sure everything is in order.",
		"I check in with some of our guests of honor. We got a good cast this year, gotta admit.",
		"Rocket Rangoon, WildPause...",
		"And the two i don’t really know too much about.",
		"[color=red]Alice Meowlice[/color] and [color=#f00]Emma Panther[/color].",
		"Folks in the group chat told me to keep an eye on them, apparently they had some drama a good while ago and had fallen out.",
		"Used to be good friends, from what i’ve heard. Weird that they accepted to be here at the same time.",
		"They haven’t looked each other in the face ever since they arrived, and so far we’ve had no issues.",
		"Alice has even donated one of her original arts from back in the day, apparently it’s one of her more iconic works.",
		"The directors wanted to keep it a secret from the attendees and reveal it at the opening."
		])

	await vn_controller.set_location(reveal, 1.0)

	await vn_controller.show_texts([
		"They even made a special podium for it. Covered dome and all that.",
		"Not even staff has been shown it."
		])

	await vn_controller.show_texts(["Wanna see what it looks like?"], {name_override="????"})

	await vn_controller.show_texts([
		"I turn to face the voice, now seeing Alice looking at the podium.",
		])

	await vn_controller.show_texts([
		"Oh, don’t worry about it, i’ve seen everyone giving it a peek. Plus, i’ve been told that staff won’t be able to participate on the auction, so as long as you don’t tell...",
		], {character=alice})

	var result = await vn_controller.show_options([
		"Uh, sure? If it is not a problem.",
		"I’m actually pretty curious, lemme see!",
		"I really don’t want to get in trouble..."
		])

	match result:
		0: await vn_controller.show_texts(["No problem at all, man!"])
		1: await vn_controller.show_texts(["Heh, knew it."])
		2: await vn_controller.show_texts(["C’mon, it’s no big deal. It’ll be our little secret."])
	
	await vn_controller.show_texts(["She reaches up to the podium, lifting the cover."])
	
	await vn_controller.set_location(empty_podium, 1.0)
	
	await vn_controller.show_texts(["........", "What?!"])
	
	await vn_controller.show_texts(["Wait, where’s...?"], {character=alice})
	
	await vn_controller.show_texts(["It's empty?!"])
	
	await vn_controller.show_texts(["Hey guys, the charity art was supposed to be here, right?"], {character=alice})
	
	await vn_controller.show_texts(["Folks start to turn around, and worry spreads through everyone’s faces."])
	
	await vn_controller.show_texts(["The hell...?"], {name_override="Staff Member 1"})
	
	await vn_controller.show_texts(["Who took it?!"], {name_override="Staff Member 2"})
	
	await vn_controller.show_texts(["Soon, everyone is gathering around the empty podium, some asking if anyone saw anything, some covering their mouths and silently worrying."])
	
	await vn_controller.show_texts(["Alright everyone, listen up!"], {name_override="????"})
	
	await vn_controller.show_texts(["From the middle of the small crowd, someone calls for attention and steps to the front."])
	
	await vn_controller.show_texts(["We got less than two hours to get things ready, so let’s improvise.",
	"Davian Avian, one of the convention’s founders, the only that remains on the board of directors."], {character=davian, name_override="????"})
	
	await vn_controller.show_texts(["Now, this is a shitty thing to find out at the last minute, but let’s try to stay calm and not point fingers just yet.",
	"This is the Noir year, so let’s use that to our advantage."], {character=davian})
	
	await vn_controller.show_texts(["He points to the empty podium."])
	
	await vn_controller.show_texts(["We’ll play it up as a treasure hunt. Everyone at the stage, when you uncover the podium, you’re gonna feign surprise about it being missing.",
	"Tell the attendees that ‘Oh no, the art got stolen!’, and let them know we’re gonna need their help.",
	"And of course, you better not slip to anyone. We’re gonna be in major trouble if word gets out that our security failed."], {character=davian})
	
	await vn_controller.show_texts(["The room feels eerily silent."])
	
	await vn_controller.show_texts(["Now, we got a con to run. Don’t let this fuck it up for everyone.”
“Understood?"], {character=davian})

	result = await vn_controller.show_options([
		"Yes, sir!",
		"YESSIR!",
		"*Nod*"])

	match result:
		0:
			await vn_controller.show_texts(["He looks at his staff, confident."])
		1:
			await vn_controller.show_texts(["C’MON, LET’S DO THIS YA’LL!"], {character=davian})
		2:
			await vn_controller.show_texts(["He nods at the crowd, but I can tell he’s worried."])

	await vn_controller.show_texts(["Alright, let’s get moving!"], {character=davian})

	await vn_controller.show_texts(["The crowd disperses, but before I can leave, Davian stops me."])

	await vn_controller.show_texts(["Hold on, I need to talk to you."], {character=davian})

	await vn_controller.show_texts(["Oh fuck..."])

	await vn_controller.show_texts(["You were there with Alice when you lifted the cover, weren’t you?"], {character=davian})

	result = await vn_controller.show_options([
		"Yes, sir.",
		"It wasn’t me, I swear!",
		"I didn’t lift the cover..."])

	match result:
		0:
			await vn_controller.show_texts(["I see."], {character=davian})
		1:
			await vn_controller.show_texts(["Don’t worry, you’re not in trouble. Yet."], {character=davian})
		2:
			await vn_controller.show_texts(["Oh I know, it’s a very Alice thing to do."], {character=davian})

	await vn_controller.show_texts(["He looks up at the cat, sighing."])

	await vn_controller.show_texts(["Gurl i’m so sorry, this shit never happens..."], {character=davian})
	
	await vn_controller.show_texts(["Ya man, it sucks. But I’m sure we’ll find it."], {character=alice})
	
	await vn_controller.show_texts(["Guess they’re familiar with each other."])
	
	while true:
		await vn_controller.show_texts(["WIP game over for now"])
	
	vn_controller.unload_all_characters()
	
func _act_2() -> void:
	pass
