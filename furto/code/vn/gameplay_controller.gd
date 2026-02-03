class_name GameplayController
extends Node

@onready var vn_controller: VNController = $VNController
#@export var placeholder_background_investigation_location: String = "res://assets/locations/placeholder_background_investigation/placeholder_background_investigation_location.tscn"
var clicked: ClickableController = null


func _init() -> void:
	Engine.register_singleton(&"G", self)


func _ready() -> void:
	await _act_1()
	await _act_2()
	#await _act_3()


func _act_1():
	# characters
	var alice := vn_controller.load_character("res://assets/characters/alice/alice.tscn")
	var davian := vn_controller.load_character("res://assets/characters/davian/davian.tscn")
	# locations
	var backstage := "res://assets/locations/backstage/backstage.tscn"
	var black := "res://assets/locations/black/black.tscn"
	var empty_podium := "res://assets/locations/empty_podium/empty_podium.tscn"
	var reveal := "res://assets/locations/reveal/reveal.tscn"
	var venue := "res://assets/locations/venue/venue.tscn"
	await vn_controller.set_location(black, 0.0)
	await vn_controller.show_texts(["The opening day.", "Such a chaotic day for the staff.", "But it’s worth it."], {})
	await vn_controller.set_location(venue, 1.0)
	await vn_controller.show_texts(["This ain’t my first rodeo as a furry conference volunteer, but it’s my first one here.", "Wanted to help my friend Boris on the organizing team, ended up being dragged here at the same time he had to step out for family reasons. At least my room was covered."], {})
	await vn_controller.set_location(backstage, 1.0)
	await vn_controller.show_texts(["In just a couple hours, the opening ceremony will take place on the stage. Hundreds of furries from many different places coming together to have a good weekend.", "That’s one of the reasons why I do this. You don’t get much recognition, but it’s nice seeing everyone smile and laugh, just like i did in my first few cons.", "In the meantime, gotta make sure everything is in order.", "I check in with some of our guests of honor. We got a good cast this year, gotta admit.", "Rocket Rangoon, WildPause…", "And two i don’t really know too much about."], {})
	await vn_controller.show_texts(["Folks in the group chat told me to keep an eye on them, apparently they had some drama a good while ago and had fallen out.", "Used to be good friends, from what i’ve heard. Weird that they accepted to be here at the same time.", "They haven’t looked each other in the face ever since they arrived, and so far we’ve had no issues.", "Alice has even donated one of her original arts from back in the day, apparently it’s one of her more iconic works.", "The directors wanted to keep it a secret from the attendees and reveal it at the opening."], {color="red"})
	await vn_controller.set_location(reveal, 1.0)
	await vn_controller.show_texts(["They even made a special podium for it. Covered dome and all that.", "Not even staff has been shown it."], {thinking=true})
	await vn_controller.show_texts(["Wanna see what it looks like?"], {name="????"})
	await vn_controller.show_texts(["I turn to face the voice, now seeing Alice looking at the podium."], {thinking=true})
	await vn_controller.show_texts(["Oh, don’t worry about it, i’ve seen everyone giving it a peek. Plus, i’ve been told that staff won’t be able to participate on the auction, so as long as you don’t tell…"], {character=alice})
	var result = await vn_controller.show_options([
		"Uh, sure? If it is not a problem.",
		"I’m actually pretty curious, lemme see!",
		"I really don’t want to get in trouble…",
	])

	match result:
		0:
			await vn_controller.show_texts(["No problem at all, man!"], {character=alice})
		1:
			await vn_controller.show_texts(["Heh, knew it."], {character=alice})
		2:
			await vn_controller.show_texts(["C’mon, it’s no big deal. It’ll be our little secret."], {character=alice})
	await vn_controller.show_texts(["She reaches up to the podium, lifting the cover."], {thinking=true})
	await vn_controller.set_location(empty_podium, 1.0)
	await vn_controller.show_texts(["…", "What?"], {thinking=true})
	await vn_controller.show_texts(["Wait, where’s…?"], {character=alice})
	await vn_controller.show_texts(["It’s empty?!"], {})
	await vn_controller.show_texts(["Hey guys, the charity art was supposed to be here, right?"], {character=alice})
	await vn_controller.show_texts(["Folks start to turn around, and worry spreads through everyone’s faces."], {thinking=true})
	await vn_controller.show_texts(["The hell…?"], {name="Staff Member 1"})
	await vn_controller.show_texts(["Who took it?!"], {name="Staff Member 2"})
	await vn_controller.show_texts(["Soon, everyone is gathering around the empty podium, some asking if anyone saw anything, some covering their mouths and silently worrying."], {thinking=true})
	await vn_controller.show_texts(["Alright everyone, listen up!"], {name="????"})
	await vn_controller.show_texts(["From the middle of the small crowd, someone calls for attention and steps to the front."], {thinking=true})
	await vn_controller.show_texts(["We got less than two hours to get things ready, so let’s improvise.", "Davian Avian, one of the convention’s founders, the only that remains on the board of directors."], {character=davian, name="????"})
	await vn_controller.show_texts(["Now, this is a shitty thing to find out at the last minute, but let’s try to stay calm and not point fingers just yet.", "This is the Noir year, so let’s use that to our advantage."], {character=davian})
	await vn_controller.show_texts(["He points to the empty podium."], {thinking=true})
	await vn_controller.show_texts(["We’ll play it up as a treasure hunt. Everyone at the stage, when you uncover the podium, you’re gonna feign surprise about it being missing.", "Tell the attendees that ‘Oh no, the art got stolen!’, and let them know we’re gonna need their help.", "And of course, you better not slip to anyone. We’re gonna be in major trouble if word gets out that our security failed."], {character=davian})
	await vn_controller.show_texts(["The room feels eerily silent."], {thinking=true})
	await vn_controller.show_texts(["Now, we got a con to run. Don’t let this fuck it up for everyone.", "Understood?"], {character=davian})
	result = await vn_controller.show_options([
		"Yes, sir!",
		"YESSIR!",
		"*Nod*",
	])

	match result:
		0:
			await vn_controller.show_texts(["He looks at his staff, confident."], {thinking=true})
		1:
			await vn_controller.show_texts(["C’MON, LET’S DO THIS YA’LL!"], {character=davian})
		2:
			await vn_controller.show_texts(["He nods at the crowd, but I can tell he’s worried."], {thinking=true})
	await vn_controller.show_texts(["Alright, let’s get moving!"], {character=davian})
	await vn_controller.show_texts(["The crowd disperses, but before I can leave, Davian stops me."], {thinking=true})
	await vn_controller.show_texts(["Hold on, I need to talk to you.”"], {character=davian})
	await vn_controller.show_texts(["Oh fuck…"], {thinking=true})
	await vn_controller.show_texts(["You were there with Alice when you lifted the cover, weren’t you?"], {character=davian})
	result = await vn_controller.show_options([
		"Yes, sir.",
		"It wasn’t me, I swear!",
		"I didn’t lift the cover….",
	])

	match result:
		0:
			await vn_controller.show_texts(["I see."], {character=davian})
		1:
			await vn_controller.show_texts(["Don’t worry, you’re not in trouble. Yet."], {character=davian})
		2:
			await vn_controller.show_texts(["Oh I know, it’s a very Alice thing to do."], {character=davian})
	await vn_controller.show_texts(["He looks up at the cat, sighing."], {thinking=true})
	await vn_controller.show_texts(["Gurl i’m so sorry, this shit never happens…"], {character=davian})
	await vn_controller.show_texts(["Ya man, it sucks. But I’m sure we’ll find it."], {character=alice})
	await vn_controller.show_texts(["Guess they’re familiar with each other."], {thinking=true})
	await vn_controller.show_texts(["I’ll make sure of it."], {character=davian})
	await vn_controller.show_texts(["He looks me up and down."], {thinking=true})
	await vn_controller.show_texts(["You’re the dude Boris brought in to replace him, right?"], {character=davian})
	await vn_controller.show_texts(["REPLACE HIM? HE DIDN’T WANT MY HELP????", "Whatever man, i just nod back."], {thinking=true, speed=2.0})
	await vn_controller.show_texts(["He hyped you up a lot, saying you had experience with dealing with problems in previous cons."], {character=davian})
	await vn_controller.show_texts(["Of course he did. Gonna need to give him some words later."], {thinking=true})
	await vn_controller.show_texts(["Well, he’s a trusted staff member, so i’ll have to believe him. Wait here."], {character=davian})
	await vn_controller.show_texts(["Excusing himself, he gathers a few board members to discuss something."], {thinking=true})
	await vn_controller.show_texts(["Man, what a mess. And for it to happen right at this year…"], {character=alice})
	result = await vn_controller.show_options([
		"Any guess as to what happened?",
		"You suspect anyone?",
	])

	match result:
		0:
			await vn_controller.show_texts(["Well, i don’t want to believe, but i can’t think of much besides theft."], {character=alice})
			await vn_controller.show_texts(["The con folks are so careful with everything, they wouldn’t misplace it."], {})
		1:
			await vn_controller.show_texts(["She looks distant, a little hesitant."], {thinking=true})
			await vn_controller.show_texts(["Well, not from the staff, at least. If i had to guess, it was someone that knew someone on the inside."], {character=alice})
	await vn_controller.show_texts(["…", "(add some more stuff about her here)", "From the back, Davian arrives with a few staff members, some of them carrying fursuit parts.", "It’s the con’s mascot, Baggy the Badger. Pretty cute design, a tubby and cuddly badger."], {thinking=true})
	await vn_controller.show_texts(["Alright, here’s the plan."], {character=davian})
	await vn_controller.show_texts(["He points at me, talking to the staff."], {thinking=true})
	await vn_controller.show_texts(["He’s Boris’ friend, the newbie. I know, i know, weird choice for this, but he’s the only one that is available and able to fit on the suit."], {character=davian})
	await vn_controller.show_texts(["One of them steps closer, sizing me up.", "She takes out a measuring tape, wrapping it around my chest and limbs."], {thinking=true})
	await vn_controller.show_texts(["Yeah, he’s the right size. Still a crazy idea, i think."], {name="Staff Member"})
	await vn_controller.show_texts(["Without Boris to wear the suit, we’d lose an opportunity to gather information. It’ll corroborate with the treasure hunt too."], {character=davian})
	await vn_controller.show_texts(["The board keeps squeezing their eyes at me, but eventually they cave in."], {thinking=true})
	await vn_controller.show_texts(["Good luck, newbie. You got big shoes - and a big badger - to fill."], {name="Staff Member"})
	await vn_controller.show_texts(["Huh…"], {thinking=true})
	await vn_controller.show_texts(["Alright newbie, here’s your job: Wear Baggy here and go around the convention, talk to folks, then report to us anything you find. Shouldn’t be too hard, yeah?"], {character=davian})
	result = await vn_controller.show_options([
		"That’s a little far fetched",
		"Yeah, i guess i can pull it off.",
		"Sigh… Boris owes me a big one for this.",
	])

	match result:
		0:
			await vn_controller.show_texts(["I know man, but do this for us, yeah?"], {character=davian})
		1:
			await vn_controller.show_texts(["You’ll do just fine, i believe!"], {character=davian})
		2:
			await vn_controller.show_texts(["You, me, and to like half the folks here."], {character=davian})
	await vn_controller.show_texts(["The people around don’t seem very convinced. Alice hasn’t said a word so far, but she also hasn’t said anything against the idea."], {thinking=true})
	await vn_controller.show_texts(["Good, let’s get you suited up."], {character=davian})
	await vn_controller.show_texts(["They take me to a dress room in the side. I change into some lighter clothes, and piece by piece i get into the Baggy suit.", "Looking at a mirror, it fits quite nicely. The design translates well into a suit, and as they put his mask over my head, it looks just like the photos i’ve been shown of previous editions of the con."], {thinking=true})
	await vn_controller.show_texts(["Not bad! Let’s put the trench coat on."], {name="Staff Member"})
	await vn_controller.show_texts(["They dress a classic detective suit over Baggy, and he looks quite dapper. Maybe i can pull this off, after all."], {thinking=true})
	await vn_controller.show_texts(["And now, your hat, mr detective."], {character=davian})
	await vn_controller.show_texts(["He puts a fedora hat on top of Baggy’s head.", "And it feels.", "Fitting.", "……."], {thinking=true})
	await vn_controller.fade_screen(0.0, 2.0)


func _act_2():
	# characters
	var Baggy := vn_controller.load_character("res://assets/characters/Baggy/Baggy.tscn")
	var baggy := vn_controller.load_character("res://assets/characters/baggy/baggy.tscn")
	var noir_alice := vn_controller.load_character("res://assets/characters/noir_alice/noir_alice.tscn")
	var noir_davian := vn_controller.load_character("res://assets/characters/noir_davian/noir_davian.tscn")
	# locations
	var black := "res://assets/locations/black/black.tscn"
	await vn_controller.set_location(black, 0.0)
	await vn_controller.show_texts(["November 14th, 2026. 7:30 AM.", "What should have been a fun and wholesome event for many critters, has devolved into another crime scene.", "A furtive theft, right under everyone’s snouts.", "The target? A valuable piece of art from a renowned artist, which was set to be auctioned tomorrow to benefit the orphans down the street.", "Whoever the lowlife was, i wonder if they knew the weight of their actions while swiping a simple piece of paper.", "No matter. They made a grave mistake."], {thinking=true})
	await vn_controller.show_texts(["They made the grave mistake of choosing the day that private detective Baggy Baroncy happened to be in town."], {character=baggy})
	await vn_controller.fade_screen(0.0, 2.0)
	await vn_controller.show_texts(["As I make my entrance, it seems that the fine people are surprised to see my imposing figure.", "Can’t say i blame them."], {thinking=true})
	await vn_controller.show_texts(["Private Detective Baggy, at your service!"], {character=baggy})
	await vn_controller.show_texts(["I reach my hand to the fine crow gentleman that seemed to be in command of the situation.", "There’s some shock in his face, but still he grips my hand in a firm shake."], {thinking=true})
	await vn_controller.show_texts(["...nice to meet you, Mr Baggy. I’m Davian Avian."], {character=noir_davian})
	await vn_controller.show_texts(["I’ve been called in to investigate a case of theft, is that right?"], {character=baggy})
	await vn_controller.show_texts(["The crow looks to his sides, as if trying to find the proper words. Or perhaps, seeking something in his staff members."], {thinking=true})
	await vn_controller.show_texts(["You, uh, surely got in character quick. I guess that works."], {character=noir_davian})
	await vn_controller.show_texts(["There’s a pause in his speech."], {thinking=true})
	await vn_controller.show_texts(["Yes, a valuable piece of art was stolen today, before being exposed to the public."], {character=noir_davian})
	var result = await vn_controller.show_options([
		"Who had access to it?",
		"Describe the artpiece.",
		"When was it last seen?",
	])

	match result:
		0:
			await vn_controller.show_texts(["Tell me mr Avian, who had direct access to the stolen item?"], {character=baggy})
			await vn_controller.show_texts(["Hmmm, i guess everyone from the staff. It didn’t require any special security, really, we never had an incident like this."], {character=noir_davian})
			await vn_controller.show_texts(["Everyone, huh? Quite a large number of suspects."], {thinking=true})
			await vn_controller.show_texts(["It seems I have my work cut out for me."], {})
		1:
			await vn_controller.show_texts(["Could you describe the artpiece? In detail, if possible."], {character=baggy})
			await vn_controller.show_texts(["It’s a traditional canvas painting, 16 by 20 inches, made by Alice Meowlice."], {character=noir_davian})
			await vn_controller.show_texts(["It features a horned white feline creature sitting below a tree, overlooking the stormy seas."], {})
			await vn_controller.show_texts(["Many observers note that the creature’s deep and distant gaze evoke feelings of introspection, embracing moments of peace before returning to life’s tempests."], {})
			await vn_controller.show_texts(["By that description, it looks like it could be sold for a hefty price."], {thinking=true})
		2:
			await vn_controller.show_texts(["When was the item last seen by anyone in the team?"], {character=baggy})
			await vn_controller.show_texts(["From what I've been told, it was just after the team arrived today. They checked the podium before moving it to where it sits now, and the canvas was still there."], {character=noir_davian})
			await vn_controller.show_texts(["Moved? Where was it before?"], {character=baggy})
			await vn_controller.show_texts(["Yes, it was in the storage room until last night."], {character=noir_davian})
			await vn_controller.show_texts(["Interesting. I'll have to check that out."], {thinking=true})
	await vn_controller.show_texts(["That's enough for me to start investigating."], {thinking=true})
	await vn_controller.show_texts(["Very well, Mr Avian, I’ll start taking a look around."], {character=baggy})
	await vn_controller.show_texts(["He nods, beckoning me to follow.", "As we leave the site, I notice the curious stares folks throw at me.", "I'm used to not being welcomed, but this feels more like I'm stranded in a different epoch.", "What a queer bunch."], {thinking=true})
	await vn_controller.show_texts(["The crow leads me to a dim-lit deposit room.", "Boxes are spread through the floor and piling up to the ceiling, colorful banners drape from the walls in an erratic manner."], {thinking=true})
	await vn_controller.show_texts(["Here we are."], {character=noir_davian})
	await vn_controller.show_texts(["He shows me a spot in the ground where the dust gives space for a square shape."], {thinking=true})
	await vn_controller.show_texts(["The guys came in the morning to carry the podium, must've been around 6 AM.", "I can't tell exactly who was tasked with carrying it, we just grabbed everyone that wasn't busy."], {character=noir_davian})
	await vn_controller.show_texts(["He seems very cautelous in not giving specifics.", "I am not sure if he's being too honest, or too trusting to point fingers at his own staff.", "Looking around, there’s still plenty of products waiting to be handled."], {thinking=true})
	await vn_controller.show_texts(["Mind if I take a look around?"], {character=baggy})
	await vn_controller.show_texts(["Of course, see if you can find anything."], {character=noir_davian})
	await vn_controller.show_texts(["I take my leave, squeezing around the cramped shelves.", "It is not easy to move around. Furniture has been pushed aside to make way for more boxes.", "A few painted boards with cartoon drawings stand in the way. Turning one aside, it reveals a badger gentleman, wearing a trench coat.", "If not for the situation, I might as well believe it was a mirror!", "Just behind it, I see something peculiar hanging from a shelf."], {thinking=true})
	await vn_controller.show_texts(["A patch of indigo and pink fur seems to have been ripped from someone.", "Inspecting the shelf, it is broken in the corner, forming a sharp edge.", "It might be nothing, but I'll hang onto it anyway."], {thinking=true})
	await vn_controller.show_texts(["Besides that, I don't see much out of the ordinary.", "I return to the crow, who is speaking with some folks."], {thinking=true})
	await vn_controller.show_texts(["Mr Avian, I'm afraid I haven't gathered much.", "I did find this, however. Does it mean anything to you?", "He takes the patch of fur into his hands, facing it to the light."], {character=Baggy})
	await vn_controller.show_texts(["Hmmm, outside of it being from a fursuit, not much."], {character=noir_davian})
	await vn_controller.show_texts(["A wolf from the folks gathered around steps to see it closer."], {thinking=true})
	await vn_controller.show_texts(["Hey, i know that!"], {name="Wolf"})
	await vn_controller.show_texts(["He takes it from the crow's hands.", "What I did not expect, however, was for him to sniff it."], {thinking=true})
	await vn_controller.show_texts(["Yeah, totally! Smells like raspberries!", "This is from Beary, one of our friends."], {name="Wolf"})
	await vn_controller.show_texts(["Beary? The hell was her suit doing here?"], {character=noir_davian})
	await vn_controller.show_texts(["I dunno man, i know she came to town early but i don't remember her being at the venue.", "Actually, I haven't seen her online since yesterday."], {name="Wolf"})
	await vn_controller.show_texts(["May I ask where this Beary is staying at?"], {character=Baggy})
	await vn_controller.show_texts(["Yeah, she's staying here in the hotel.", "Room 2418, right?"], {character=noir_davian})
	await vn_controller.show_texts(["The wolf nods."], {thinking=true})
	await vn_controller.show_texts(["Very well, then. I'll go talk to her while you folks keep doing your thing here."], {character=Baggy})
	await vn_controller.show_texts(["The crow nods his head, while the wolf seems a bit apprehensive.", "As I return to the backstage, the crew is in a hurry, no doubt exacerbated by the missing art piece.", "A sharply-dressed feline approaches as I enter the hall. Her eyes meet mine, and I sense familiarity in her gaze."], {thinking=true})
	await vn_controller.show_texts(["Look at that! You look great in the Baggy suit, man!"], {character=noir_alice})
	await vn_controller.show_texts(["She addresses me as if we were long time companions, in complete opposition to how every fur has treated me so far.", "It is heartwarming to see a welcoming face, but I wish I could reciprocate the familiarity."], {thinking=true})
	result = await vn_controller.show_options([
		"Forgive me ma'am, it seems I have forgotten your name.",
		"It's best if I introduce myself proper.",
	])

	match result:
		0:
			await vn_controller.show_texts(["Forgive me, ma'am. My work takes me to many places, and often times all the faces blur into one."], {character=Baggy})
			await vn_controller.show_texts(["If we have met before, may I ask your name again?"], {})
			await vn_controller.show_texts(["She stops for a second, staring at me, as if waiting for a follow up."], {thinking=true})
			await vn_controller.show_texts(["I find it more appropriate to let her answer in her own time."], {})
			await vn_controller.show_texts(["…I'm Alice…"], {character=noir_alice})
		1:
			await vn_controller.show_texts(["A pleasure to meet you again, miss Alice."], {character=Baggy})
	await vn_controller.show_texts(["Anyway…", "Did you find anything in there?"], {character=noir_alice})
	await vn_controller.show_texts(["About the investigation, yes? I heard it was your art piece that was stolen.", "See, I found some patch of fur at the place the painting was stored at.", "I have been told it matches with one called Beary."], {character=Baggy})
	await vn_controller.show_texts(["Beary? I've seen her in the last few cons, she's always hanging out with the crew after the event ends."], {character=noir_alice})
	await vn_controller.show_texts(["I see. She's a regular, then."], {thinking=true})
	await vn_controller.show_texts(["That's good to know. I'm heading to her hotel room now, it seems she hasn't been heard of since yesterday."], {character=Baggy})
	await vn_controller.show_texts(["I hope she's alright. Take care, uh, Mr Baggy…"], {character=noir_alice})
	await vn_controller.show_texts(["I say my goodbye, and tip my fedora in respect.", "Her eyes tell me she didn't appreciate my respect."], {thinking=true})
	await vn_controller.show_texts(["*change scenery to convention*", "I head to the elevators, and on the way I see a venue already filled with furs of the most diverse species.", "A few of them stop me and ask for a photograph.", "It's an unusual request for me, but I indulge them for a second.", "At the elevator hall, I call the lift and wait. A number lights up atop the doors, showing floor numbers in the dozens.", "To my side, I hear soft pawsteps from high heels on carpeted floors.", "I turn around to see a black panther. Her eyes stare deep into mine, confidence flowing from them and seeping into her firm gait.", "She approaches me without fear. I can tell from her pose that she hopes to instill that fear in me.", "Maybe it is working, even if just a tiny bit."], {comment=true})
	var noir_emma := vn_controller.load_character("res://assets/characters/noir_emma/noir_emma.tscn")
	await vn_controller.show_texts(["You're going to Beary's room, right?"], {character=noir_emma})
	result = await vn_controller.show_options([
		"That would be right, miss…?",
		"Avoid the question,",
	])

	match result:
		0:
			await vn_controller.show_texts(["That would be right. I fear we haven't been presented yet, miss…?"], {character=Baggy})
			await vn_controller.show_texts(["You know my name is Emma. You literally spoke to me this morning."], {character=noir_emma})
			await vn_controller.show_texts(["Emma. I wonder why my memory is failing me today."], {thinking=true})
			await vn_controller.show_texts(["Might be the discount whisky from the corner pub."], {})
		1:
			await vn_controller.show_texts(["Sorry ma'am, I'm simply heading to my room."], {character=Baggy})
			await vn_controller.show_texts(["Don't play dumb, I heard you talking to that bitch in the backstage."], {character=noir_emma})
			await vn_controller.show_texts(["And don't call me ma'am, that's creepy as fuck. I'm Emma."], {})
			await vn_controller.show_texts(["Emma. Quite a crass feline, if i'm to say."], {thinking=true})
	await vn_controller.show_texts(["Anyway, I'm coming with you. Gotta check on her."], {character=noir_emma})
	await vn_controller.show_texts(["Very well, you may accompany me."], {character=Baggy})
	await vn_controller.show_texts(["The doors open, and a few furs come out from inside the lift. When it empties, it is only me and the panther.", "I press the button for the 24th floor, and the doors close.", "The journey is silent.", "She stares at the door, unflinching.", "I don't attempt to start any conversation, either.", "We arrived on floor 24. Stepping out, she walks behind me, keeping a good distance.", "For a busy event, it is weird to see a hotel floor be this empty.", "We stand in front of room 2418, at the end of the hallway. Emma is right behind, leaning on the wall.", "I raise my hand, and my knuckles gently knock on the door. There's no answer.", "I knock again, a little harder. Still, no answer."], {thinking=true})
	await vn_controller.show_texts(["Miss Beary? Are you in there?"], {character=Baggy})
	await vn_controller.show_texts(["Only silence."], {thinking=true})
	await vn_controller.show_texts(["Try the door handle."], {character=noir_emma})
	await vn_controller.show_texts(["There's no way it is open."], {character=baggy})
	await vn_controller.show_texts(["I grab the handle anyway, to show the foolishness of her suggestion.", "…", "It opens."], {thinking=true})
	await vn_controller.show_texts(["See? Go right ahead."], {character=noir_emma})
	await vn_controller.show_texts(["I groan, but I have to admit when I'm defeated.", "I step inside the room, with no one in sight.", "The bedsheets are unturned, and the luggage strewn across the floor tells me someone has been here, at least.", "Some personal belongings, however, makes me think she's still in the room. The bathroom, perhaps?"], {thinking=true})
	await vn_controller.show_texts(["Miss Beary? Sorry to intrude, I…"], {character=Baggy})
	await vn_controller.show_texts(["Behind me, I hear something being lifted from the floor."], {thinking=true})
	await vn_controller.show_texts(["Miss Emma?", "Before I can properly turn around, something bashes against the side of my head.", "It sends me toppling to the ground, and my vision flares with the pain.", "Desperately, I try to grab something to help me up.", "Before I can, however, my head is bashed again.", "And the world goes dark.", "….", "To be Continued."], {character=Baggy})
	await vn_controller.show_texts(["End of ACT 2."], {comment=true})


func _act_3():
	# location
	var investigation := "res://assets/locations/hotel/hotel_2418_entrance.tscn"
	await vn_controller.set_location(investigation, 0.0)
