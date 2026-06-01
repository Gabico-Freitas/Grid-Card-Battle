extends Control
class_name Hand_Card

@export var player: Player
var cards : Array[Card_Ui] = []
var current_card: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i=0
	for child in $HBoxContainer/Hand.get_children():
		if child is Button:
			cards.append(child)
			cards[i].set_pos(i+1)
			child.connect("card_selected", _on_card_selected)
			#assign_card(i+1)
			i+=1


func _on_card_selected(card_ui: Card_Ui): #Falta fazer
	if card_ui.button_pressed:
		player.selected_card = card_ui.card_data
		player._update_highlight_card_aof()
	else:
		player.selected_card = null
		player._update_highlight_card_aof()

func update_hand(player_hand : Array[Card]):
	deck_label()
	player.selected_card = null
	for i in range(cards.size()):
		if i < player_hand.size():
			var card = player_hand[i]
			cards[i].button_pressed = false
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
			discard_label()

func discard_label() -> void:
	$HBoxContainer/Discard/DiscardLabel.text = str(player.discard_pile.size())
func deck_label() -> void:
	$HBoxContainer/Deck/DeckLabel.text = str(player.draw_pile.size())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_player_turn_ended() -> void:
	discard_label()
