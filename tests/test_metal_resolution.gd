extends Node

const ChanceCardMgr = preload("res://scripts/core/chance_card_manager.gd")
const ChanceCardData = preload("res://scripts/core/chance_card_data.gd")

var manager

func _ready():
	print("\n===== METAL DECK RESOLUTION TEST START =====")
	_setup_clean_game_state()
	_run_all_metal_deck_tests()
	print("===== METAL DECK RESOLUTION TEST COMPLETE =====\n")
	get_tree().quit()


# Setup Teset
func _setup_clean_game_state():
	GameState.players.clear()

	GameState.player_count = 3
	GameState.current_player_index = 0

	for i in range(3):
		var player = PlayerState.new()
		player.player_id = i
		player.balance = 1500
		player.total_data_points = 2
		player.total_discoveries = 1
		GameState.players.append(player)

	manager = ChanceCardMgr.new()
	add_child(manager)

# Run test
func _run_all_metal_deck_tests():
	for card_num in range(0, 18):
		_reset_balances()
		_test_card(card_num)


func _reset_balances():
	for player in GameState.players:
		player.balance = 1500


# Card Logic
func _test_card(card_num: int):

	var card_data = ChanceCardData.get_card_info(card_num)

	var starting_balances = _get_balances_copy()

	manager.resolve_card(
		card_num,
		card_data["functionalValue"],
		card_data["movementValue"],
		0
	)

	var expected_balances = _calculate_expected(card_num, card_data, starting_balances)
	var actual_balances = _get_balances_copy()

	if expected_balances == actual_balances:
		print("✅ Card ", card_num, " PASSED")
	else:
		print("❌ Card ", card_num, " FAILED")
		print("Expected: ", expected_balances)
		print("Actual:   ", actual_balances)


# Calculations for the Expected Outcomes from cards
func _calculate_expected(card_num: int, card_data: Dictionary, start_balances: Array) -> Array:
	var result = start_balances.duplicate()
	var current = GameState.current_player_index
	var player_count = GameState.player_count

	# Simple credit cards (0–9)
	if card_num >= 0 and card_num <= 9:
		result[current] += card_data["functionalValue"]

	# Simple debit cards (10–13)
	elif card_num >= 10 and card_num <= 13:
		result[current] -= card_data["functionalValue"]

	# Pay each player $50
	elif card_num == 14:
		var amount_per_player = 50
		result[current] -= amount_per_player * (player_count - 1)
		for i in range(player_count):
			if i != current:
				result[i] += amount_per_player

	# Collect $10 from each player
	elif card_num == 15:
		var amount_per_player = 10
		result[current] += amount_per_player * (player_count - 1)
		for i in range(player_count):
			if i != current:
				result[i] -= amount_per_player

	# Pay per Data Point & Discovery
	elif card_num == 16:
		var data_points = GameState.players[current].total_data_points
		var discoveries = GameState.players[current].total_discoveries
		var fee = (45 * data_points) + (120 * discoveries)
		result[current] -= fee

	# Alternate pay per Data Point & Discovery
	elif card_num == 17:
		var data_points = GameState.players[current].total_data_points
		var discoveries = GameState.players[current].total_discoveries
		var fee = (25 * data_points) + (100 * discoveries)
		result[current] -= fee

	return result


func _get_balances_copy() -> Array:
	var balances := []
	for player in GameState.players:
		balances.append(player.balance)
	return balances
