extends Control

@onready var paper1: Panel = $Paper1
@onready var paper2: Panel = $Paper2

func _ready():
	# 为纸张1设置内容（字符串列表）
	paper1.pages = [
		"图鉴 第1页：史莱姆\n属性：水\n弱点：火",
		"图鉴 第2页：哥布林\n属性：地\n弱点：风",
		"图鉴 第3页：龙\n属性：火\n弱点：冰"
	]
	
	# 为纸张2设置内容（可以是图片路径，但这里仍用文本示例）
	paper2.pages = [
		"装备 第1页：铁剑\n攻击+5",
		"装备 第2页：皮甲\n防御+3",
		"装备 第3页：药水\n恢复HP"
	]
	
	# 可选：连接翻页信号
	paper1.page_changed.connect(_on_paper1_page_changed)
	paper2.page_changed.connect(_on_paper2_page_changed)

func _on_paper1_page_changed(index: int):
	print("纸张1翻到第", index + 1, "页")

func _on_paper2_page_changed(index: int):
	print("纸张2翻到第", index + 1, "页")
