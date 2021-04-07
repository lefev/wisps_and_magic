extends MarginContainer

const start_scene = preload("res://scenes/main/Main.tscn")
const option_menu = preload("res://menus/option/OptionMenu.tscn")

onready var selector_start : Sprite = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/SelectorSprite
onready var selector_options : Sprite = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/SelectorSprite
onready var selector_quit : Sprite = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/SelectorSprite

enum MENU_STATE{START, OPTIONS, QUIT}

var current_state : int = MENU_STATE.START
onready var max_state : int = MENU_STATE.size() - 1 
onready var min_state : int = 0


func _ready() -> void:
	set_current_selection(MENU_STATE.START)


func _process(_delta: float) -> void:
	move_selection()
	if Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_state)
	elif Input.is_action_just_pressed("ui_cancel"):
		close_game()


func handle_selection(_current_state) -> void:
	match current_state:
			MENU_STATE.START:
				get_parent().add_child(start_scene.instance())
				queue_free()
			MENU_STATE.OPTIONS:
				get_parent().add_child(option_menu.instance())
				queue_free()
			MENU_STATE.QUIT:
				close_game()


func move_selection() -> void:
	if Input.is_action_just_pressed("ui_down"):
		current_state += 1
		if current_state > max_state:
			current_state = min_state
		set_current_selection(current_state)
	elif Input.is_action_just_pressed("ui_up"):
		current_state -= 1
		if current_state < min_state:
			current_state = max_state
		set_current_selection(current_state)


func clear_all_selectors() -> void:
	selector_start.visible = false
	selector_options.visible = false
	selector_quit.visible = false


func set_current_selection(_current_state) -> void:
	clear_all_selectors()
	match current_state:
		MENU_STATE.START:
			selector_start.visible = true
		MENU_STATE.OPTIONS:
			selector_options.visible = true
		MENU_STATE.QUIT:
			selector_quit.visible = true


func close_game() -> void:
	get_tree().quit()
