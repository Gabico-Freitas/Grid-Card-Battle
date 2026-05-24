extends Control
class_name Hand_Card

@export var player: Player
var cards : Array[Card_Ui] = []
var current_card: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i=0
	for child in $HBoxContainer.get_children():
		if child is Button:
			cards.append(child)
			cards[i].set_pos(i+1)
			child.connect("card_selected", _on_card_selected)
			#assign_card(i+1)
			i+=1
		

func assign_card(card: Card) -> void:
	cards[current_card].set_card(card)
	print(card.id)
	if card.id ==1:
		cards[current_card].icon = ResourceLoader.load("res://UI/cards_images/spear_image.png")
	if card.id ==2:
		cards[current_card].icon = ResourceLoader.load("res://UI/cards_images/arrow_image.png")
	if card.id ==3:
		cards[current_card].icon = ResourceLoader.load("res://UI/cards_images/slash_image.png")
	if card.id ==4:
		cards[current_card].icon = ResourceLoader.load("res://UI/cards_images/hammer_image.png")
	if card.id ==5:
		cards[current_card].icon = ResourceLoader.load("res://UI/cards_images/punch_image.png")
	
	if current_card==5:
		current_card =0
	else:
		current_card+=1

func _on_card_selected(card_ui: Card_Ui): #Falta fazer
	var event = InputEventKey.new()

	match card_ui.card_data.id:
		1: event.keycode = KEY_1
		2: event.keycode = KEY_2
		3: event.keycode = KEY_3
		4: event.keycode = KEY_4
		5: event.keycode = KEY_5
	event.pressed = true
	Input.parse_input_event(event)
	player.selected_card = card_ui.card_data

func update_hand(player_hand : Array[Card]):
	for i in range(cards.size()):
		if i < player_hand.size():
			var card = player_hand[i]
			cards[i].visible = true
			cards[i].setup(card, i)
			if card.id ==1:
				cards[i].icon = preload("res://UI/cards_images/spear_image.png")
			if card.id ==2:
				cards[i].icon = preload("res://UI/cards_images/arrow_image.png")
			if card.id ==3:
				cards[i].icon = preload("res://UI/cards_images/slash_image.png")
			if card.id ==4:
				cards[i].icon = preload("res://UI/cards_images/hammer_image.png")
			if card.id ==5:
				cards[i].icon = preload("res://UI/cards_images/punch_image.png")
		else:
			cards[i].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
