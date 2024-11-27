extends Node

var possible_dialogue:Array[String] = [
"Your secret is safe with me",
"I won't say a word",
"You've got my world, it stays with me",
"That’s a big thing to share, I’m honored you told me.",
"Your secret’s safe with me, like a squirrel guarding a stash of acorns.",
"I swear on my collection of sock puppets, I won’t tell anyone!",
"I’ll hide your secret in my brain so deep, even Google won’t find it!",
"Your secret’s in the vault, and I’ve got the combination… but I lost it, so don’t worry, it’s safe!",
"I’ll keep it more secret than the last cookie in the jar!"
]



func _give_random_dialogue()->String:
	return possible_dialogue.pick_random()
