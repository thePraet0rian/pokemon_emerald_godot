# Bottom Panel Shortcuts

Plugin for Godot 4. Provides configurable shortcuts for toggling bottom panel and for toggling any bottom window. Toggling for bottom windows works based on position and current visibility of their buttons.

It supports toggle for any bottom window, even the ones that were added through plugins.

## Default shortcuts
- Ctrl + Space: Toggle bottom panel
- Alt + 1: Toggle 1st visible button
- Alt + 2: Toggle 2nd visible button
...
- Alt + 9: Toggle 9th visible button

## Hot to change default shortcuts?
1. Open your project settings
2. Enable "Advaned setting"
3. Go to "Plugin" > "Bottom Window Shortcuts"

**Project settings window**
<br>
<img src="screenshots/settings.png" >
<br>

There you will be able to change Shortcut resource
<br>
<img src="screenshots/configure.png" >
<br>

Note: You can't load tres files into here, it is unsupported and will cause project manager to be unable to load this project. If you set tres file here, open project.godot and under \[plugin\] setting delete any bottom_panel_shortcuts\\setting that contains Resource("file_path")

## How does bottom windows shortcuts work?
The window that will be toggled is based on currently activated shortcut's position in the array. When shortcut is activated all buttons are filtered by visibility and then accessed by shortcut's index.
 
Because of this, theoretically this should be able to support any number of bottom panel windows, by way of growing this array. Or you can make the array smaller, if you think that default number of shortcuts is too large, or you already use these keys for other commands.

If you don't want to toggle 3rd or 4th window, but still want to toggle buttons further in the position you can clear shortcut resource, or you can change resource to not listen to any input.