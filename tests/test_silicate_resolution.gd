extends Node

const ChanceCardMgr = preload("res://scripts/core/chance_card_manager.gd")
const ChanceCardData = preload("res://scripts/core/chance_card_data.gd")

var manager

func _ready():
	print("\n=== SILICATE DECK MOVEMENT TEST START ===")
	_setup_clean_game_state()
	_run_all_silicate_tests()
	print("=== SILICATE DECK MOVEMENT TEST COMPLETE ===\n")
	get_tree().quit()


# Setup needed for test
func _setup_clean_game_state():
	GameState.players.clear()

	GameState.player_count = 1
	GameState.current_player_index = 0

	var player = PlayerState.new()
	player.player_id = 0
	player.balance = 1500
	player.board_space = 0
	GameState.players.append(player)

	manager = ChanceCardMgr.new()
	add_child(manager)


# Runs the Test
func _run_all_silicate_tests():
	for card_num in range(18, 36):
		_reset_player()
		_test_card(card_num)


func _reset_player():
	GameState.players[0].balance = 1500
	GameState.players[0].board_space = 0


# Required card logic for test
func _test_card(card_num: int):
	var card_data = ChanceCardData.get_card_info(card_num)
	var player = GameState.players[0]
	var start_position = player.board_space
	var start_balance = player.balance

	manager.resolve_card(
		card_num,
		card_data["functionalValue"],
		card_data["movementValue"],
		start_position
	)

	var expected_position = _calculate_expected_position(card_num, card_data, start_position, start_balance)
	var expected_balance = _calculate_expected_balance(card_num, start_position)

	var actual_position = player.board_space
	var actual_balance = player.balance

	if expected_position == actual_position and expected_balance == actual_balance:
		print("✅ Card ", card_num, " PASSED")
	else:
		print("❌ Card ", card_num, " FAILED")
		print("Expected Pos:", expected_position, " Actual:", actual_position)
		print("Expected Bal:", expected_balance, " Actual:", actual_balance)


# Calculates the correct ending position
func _calculate_expected_position(card_num: int, card_data: Dictionary, start_position: int, start_balance: int) -> int:
	# Cards that directly move to a space
	if card_num in [18,19,20,21,22,23,24,25,26,27,32,33]:
		#var forward_movement = 0
		#var movement_value = manager.resolve_card.card_data["movementValue"]
		#if start_position < movement_value:
			#forward_movement = movement_value - start_position
		#elif start_position > movement_value:
			#forward_movement = (40 - start_position) + movement_value
		
		return card_data["movementValue"]
	
	if card_num in [18,19,20,21,22,23,24,25,32,33]:
		#var forward_movement = 0
		#var movement_value = manager.resolve_card.card_data["movementValue"]
		#if start_position < movement_value:
			#forward_movement = movement_value - start_position
		#elif start_position > movement_value:
			#forward_movement = (40 - start_position) + movement_value
		
		return card_data["movementValue"]

	if card_num in [26,27]:
		GameState.players[0].player.balance = start_balance + 200
		return card_data["movementValue"]

	# Go back 3 spaces
	if card_num == 31:
		return (start_position - 3 + 40) % 40

	# Nearest instrument/planet 
	if card_num in [28,29]:
		var instrument1_distance = abs(start_position - 5)
		var instrument2_distance = abs(start_position - 15)
		var instrument3_distance = abs(start_position - 25)
		var instrument4_distance = abs(start_position - 35)
		var instrucment_movement = min(instrument1_distance, instrument2_distance, instrument3_distance, instrument4_distance)
		
		if instrucment_movement == instrument1_distance:
			return 5
		elif instrucment_movement == instrument2_distance:
			return 15
		elif instrucment_movement == instrument3_distance:
			return 25
		elif instrucment_movement == instrument4_distance:
			return 35

	# Nearest planet 
	if card_num in [30]:	
		var mars_distance = abs(start_position - 12)
		var jupiter_distance = abs(start_position - 27)
		
		if mars_distance < jupiter_distance:
			return 12
		else:
			return 27


	# Get out of Launch Pad (no movement)
	if card_num in [34,35]:
		return start_position

	return start_position


# Calculates the expected player balances after movement
func _calculate_expected_balance(card_num: int, start_position: int) -> int:

	var balance = 1500

	# Cards that advance forward and may pass GO
	if card_num in [18,19,20,21,22,23,24,25]:

		var target_space = ChanceCardData.get_card_info(card_num)["movementValue"]

		# If target is behind current position → passed GO
		if target_space < start_position:
			balance += 200

	# Advance to GO explicitly
	if card_num in [26,27]:
		balance += 200

	# Launch Pad cards (no pass GO bonus)
	if card_num in [32,33]:
		pass

	# All other cards do not affect money
	return balance
