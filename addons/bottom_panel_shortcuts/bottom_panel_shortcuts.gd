@tool
extends EditorPlugin

const PLUGIN_ID := "bottom_panel_shortcuts"
const PLUGIN_PATH := "plugins/" + PLUGIN_ID

const USE_SET_INPUT_AS_HANDLED_KEY := PLUGIN_PATH + "/use_set_input_as_handled"
const TOGGLE_PANEL_KEY := PLUGIN_PATH + "/toggle_bottom_panel"
const USE_BOTTOM_WINDOWS_SHORTCUTS_KEY := PLUGIN_PATH + "/use_bottom_windows_shortcuts"
const BOTTOM_WINDOWS_TOGGLE_MODE_KEY := PLUGIN_PATH + "/bottom_windows_toggle_mode"
const BOTTOM_WINDOWS_SHORTCUTS_KEY := PLUGIN_PATH + "/bottom_windows_shortcuts"

const DEFAULT_SHORTCUTS_KEYS = [KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9]

var _bottom_buttons_parent: Node = null
var _button: Button = null

var _toggle_shortcut: Shortcut = Shortcut.new()
var _windows_shortcuts: Array


func _enter_tree() -> void:
	_plugin_setup()

	var temp_cotrol := Control.new()
	var temp_button := add_control_to_bottom_panel(temp_cotrol, "Temp Control")
	_bottom_buttons_parent = temp_button.get_parent()
	remove_control_from_bottom_panel(temp_cotrol)

	var children = _get_visible_child_buttons(_bottom_buttons_parent)
	_button = children[0] as Button

	_bottom_buttons_parent.child_entered_tree.connect(_connect_bottom_buttons_handler)
	_connect_bottom_buttons.call_deferred()


func _exit_tree() -> void:
	_bottom_buttons_parent.child_entered_tree.disconnect(_connect_bottom_buttons_handler)
	_disconnect_bottom_buttons()


# set initial settings and initial value
# if they exist, then just initial value
# initial value needs to always be set
# property_info needs to always be set
func _plugin_setup() -> void:
	_set_default_toggle_panel()
	_set_default_bools()
	_set_default_bottom_windows_shortcuts()
	_set_property_infos()
	_set_settings_order()


func _set_default_toggle_panel() -> void:
	var input = InputEventKey.new()
	input.keycode = KEY_SPACE
	input.ctrl_pressed = true

	_toggle_shortcut.events.append(input)

	_set_setting_or_default(TOGGLE_PANEL_KEY, _toggle_shortcut)


func _set_default_bools() -> void:
	_set_setting_or_default(USE_SET_INPUT_AS_HANDLED_KEY, true)
	_set_setting_or_default(USE_BOTTOM_WINDOWS_SHORTCUTS_KEY, true)
	_set_setting_or_default(BOTTOM_WINDOWS_TOGGLE_MODE_KEY, true)


func _set_default_bottom_windows_shortcuts() -> void:
	var count = 1
	for key in DEFAULT_SHORTCUTS_KEYS:
		var input = InputEventKey.new()
		input.keycode = key
		input.alt_pressed = true

		var shortcut: Shortcut = Shortcut.new()
		shortcut.events.append(input)
		shortcut.resource_name = "Show window %d" % count

		_windows_shortcuts.append(shortcut)
		count += 1

	_set_setting_or_default(BOTTOM_WINDOWS_SHORTCUTS_KEY, _windows_shortcuts)


func _set_setting_or_default(settting_name: String, value: Variant) -> void:
	if not ProjectSettings.has_setting(settting_name):
		ProjectSettings.set_setting(settting_name, value)

	ProjectSettings.set_initial_value(settting_name, value)


func _set_property_infos():
	var property_set_as_handles := {
		"name": USE_SET_INPUT_AS_HANDLED_KEY,
		"type": TYPE_BOOL,
	}
	var property_toggle_panel := {
		"name": TOGGLE_PANEL_KEY,
		"type": TYPE_OBJECT,
		"hint": PROPERTY_HINT_RESOURCE_TYPE,
		"hint_string": "Shortcut"
	}
	var property_show_hotkeys := {
		"name": USE_BOTTOM_WINDOWS_SHORTCUTS_KEY,
		"type": TYPE_BOOL,
	}
	var property_toggle_mode := {
		"name": BOTTOM_WINDOWS_TOGGLE_MODE_KEY,
		"type": TYPE_BOOL,
	}
	var property_show_panel := {
		"name": BOTTOM_WINDOWS_SHORTCUTS_KEY,
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"hint_string": "%d/%d:Shortcut" % [TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE]
	}
	ProjectSettings.add_property_info(property_set_as_handles)
	ProjectSettings.add_property_info(property_toggle_panel)
	ProjectSettings.add_property_info(property_show_hotkeys)
	ProjectSettings.add_property_info(property_toggle_mode)
	ProjectSettings.add_property_info(property_show_panel)


func _set_settings_order() -> void:
	ProjectSettings.set_order(USE_SET_INPUT_AS_HANDLED_KEY, 800)
	ProjectSettings.set_order(TOGGLE_PANEL_KEY, 801)
	ProjectSettings.set_order(USE_BOTTOM_WINDOWS_SHORTCUTS_KEY, 802)
	ProjectSettings.set_order(BOTTOM_WINDOWS_TOGGLE_MODE_KEY, 803)
	ProjectSettings.set_order(BOTTOM_WINDOWS_SHORTCUTS_KEY, 804)


func _connect_bottom_buttons_handler(_node: Node) -> void:
	_connect_bottom_buttons()


# connect callback to every toggle and pressed signal,
# can be called several times
func _connect_bottom_buttons() -> void:
	for child in _bottom_buttons_parent.get_children():
		if not child is Button:
			continue

		var bound_toggled := _bottom_button_toggled.bind(child)
		if not child.toggled.is_connected(bound_toggled):
			child.toggled.connect(bound_toggled)

		var bound_pressed := _bottom_button_pressed.bind(child)
		if not child.pressed.is_connected(bound_pressed):
			child.pressed.connect(bound_pressed)


# disconnect callback from every toggle and pressed signal
func _disconnect_bottom_buttons() -> void:
	for child in _bottom_buttons_parent.get_children():
		if not child is Button:
			continue

		var bound_toggled := _bottom_button_toggled.bind(child)
		if child.toggled.is_connected(bound_toggled):
			child.toggled.disconnect(bound_toggled)

		var bound_pressed := _bottom_button_pressed.bind(child)
		if child.pressed.is_connected(bound_pressed):
			child.pressed.disconnect(bound_pressed)


func _bottom_button_toggled(_value: bool, panel_button: Button) -> void:
	_button = panel_button


func _bottom_button_pressed(panel_button: Button) -> void:
	_button = panel_button


# Left here for the symmetry with _disable_plugin
func _enable_plugin() -> void:
	pass


# Clear ups custom setting
func _disable_plugin() -> void:
	ProjectSettings.set_setting(USE_SET_INPUT_AS_HANDLED_KEY, null)
	ProjectSettings.set_setting(TOGGLE_PANEL_KEY, null)
	ProjectSettings.set_setting(USE_BOTTOM_WINDOWS_SHORTCUTS_KEY, null)
	ProjectSettings.set_setting(BOTTOM_WINDOWS_TOGGLE_MODE_KEY, null)
	ProjectSettings.set_setting(BOTTOM_WINDOWS_SHORTCUTS_KEY, null)
	ProjectSettings.save()


# Godot saves resources different from initial values into project.godot,
# but if you changed resource(InputEventKey) in a resource, original
# reference is still the same. Check if you changed resources inside,
# and if you did, duplicate base resource and set it back
# ProjectSettings.save will pick it up after that
func _save_external_data() -> void:
	_save_toggle_shortcut()
	_save_bottom_windows_shortcuts()
	ProjectSettings.save()


func _save_toggle_shortcut() -> void:
	var shortcut = ProjectSettings.get_setting(TOGGLE_PANEL_KEY)

	# only check if it is initial instance
	if shortcut == _toggle_shortcut:
		var input = InputEventKey.new()
		input.keycode = KEY_SPACE
		input.ctrl_pressed = true

		if _check_input_needs_save(shortcut.events, input):
			var shortcut_copy = shortcut.duplicate()
			ProjectSettings.set_setting(TOGGLE_PANEL_KEY, shortcut_copy)


func _save_bottom_windows_shortcuts() -> void:
	var windows_shortcuts := ProjectSettings.get_setting(BOTTOM_WINDOWS_SHORTCUTS_KEY) as Array

	# only check if it is initial instance
	if _windows_shortcuts != windows_shortcuts:
		return

	var keys = []
	for key in DEFAULT_SHORTCUTS_KEYS:
		var input = InputEventKey.new()
		input.keycode = key
		input.alt_pressed = true
		keys.append(input)

	for i in windows_shortcuts.size():
		if i >= keys.size():
			break
		if not is_instance_valid(windows_shortcuts[i]):
			continue

		if _check_input_needs_save(windows_shortcuts[i].events, keys[i]):
			var copy = windows_shortcuts[i].duplicate()
			windows_shortcuts[i] = copy


func _check_input_needs_save(events: Array, key: InputEventKey) -> bool:
	if events.size() == 0 or events.size() > 1:
		return true
	if not is_instance_valid(events[0]):
		return true
	if events[0].as_text() != key.as_text():
		return true

	return false


func _input(event: InputEvent) -> void:
	if not event.is_pressed():
		return

	var use_set_input_as_handled := (
		ProjectSettings.get_setting(USE_SET_INPUT_AS_HANDLED_KEY, true) as bool
	)

	var panel_toggled = _handle_toggle_shortcut(event)
	var window_toggled = _handle_windows_shortcuts(event)

	if use_set_input_as_handled and (panel_toggled or window_toggled):
		get_viewport().set_input_as_handled()


func _handle_toggle_shortcut(event: InputEvent) -> bool:
	var shortcut = ProjectSettings.get_setting(TOGGLE_PANEL_KEY, _toggle_shortcut)
	if (
		is_instance_valid(_button)
		and is_instance_valid(shortcut)
		and shortcut.matches_event(event)
		and _button.visible
	):
		_button.toggled.emit(!_button.button_pressed)
		return true
	return false


func _handle_windows_shortcuts(event: InputEvent) -> bool:
	var use_shortcuts := ProjectSettings.get_setting(USE_BOTTOM_WINDOWS_SHORTCUTS_KEY, true) as bool
	var toggle_mode := ProjectSettings.get_setting(BOTTOM_WINDOWS_TOGGLE_MODE_KEY, true) as bool
	if not use_shortcuts:
		return false

	var windows_shortcuts = ProjectSettings.get_setting(
		BOTTOM_WINDOWS_SHORTCUTS_KEY, _windows_shortcuts
	)
	var index = _find_first_shortcut(windows_shortcuts, event)
	if index < 0:
		return false

	var children = _get_visible_child_buttons(_bottom_buttons_parent)
	if index < children.size():
		var child = children[index]
		var toggle_value = !child.button_pressed if toggle_mode else true
		child.toggled.emit(toggle_value)
		return true
	return false


func _find_first_shortcut(shortcuts: Array, event: InputEvent) -> int:
	for i in shortcuts.size():
		if is_instance_valid(shortcuts[i]) and shortcuts[i].matches_event(event):
			return i
	return -1


func _get_visible_child_buttons(parent: Node) -> Array:
	return parent.get_children().filter(func(c): return c is Button and c.visible)
