extends Panel

# 信号：翻页时发出，传递当前页码
signal page_changed(index)

# 存储所有页内容的数组（可以是字符串、纹理资源等）
var pages := [] : set = _set_pages
var current_page := 0 : set = _set_current_page

# 节点引用
@onready var content_label: Label = $MarginContainer/VBoxContainer/ContentLabel
@onready var prev_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/Last
@onready var next_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/Next

func _ready():
	# 连接按钮信号
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	# 初始更新
	_update_display()

# 设置页数组（外部调用）
func _set_pages(value):
	pages = value
	current_page = 0  # 重置到第一页
	_update_display()

# 设置当前页（可外部调用直接跳转）
func _set_current_page(value):
	if pages.is_empty():
		current_page = -1
		return
	current_page = clampi(value, 0, pages.size() - 1)
	page_changed.emit(current_page)
	_update_display()

# 更新显示内容及按钮状态
func _update_display():
	if pages.is_empty():
		content_label.text = "无内容"
		prev_button.disabled = true
		next_button.disabled = true
		return
	
	# 显示当前页内容（支持字符串或纹理，此处以字符串为例）
	var content = pages[current_page]
	if content is String:
		content_label.text = content
	elif content is Texture2D:
		# 如果内容是纹理，可以改用TextureRect显示
		# 这里简单示例，实际可能需要更复杂的节点切换
		content_label.text = "[纹理]"
	
	# 更新按钮可用状态
	prev_button.disabled = (current_page <= 0)
	next_button.disabled = (current_page >= pages.size() - 1)

# 上一页
func _on_prev_pressed():
	current_page -= 1

# 下一页
func _on_next_pressed():
	current_page += 1

# 可选：获取当前页内容
func get_current_content():
	return pages[current_page] if not pages.is_empty() else null
